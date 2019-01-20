module PaymentProcessorAdapter

  def self.current_adapter
    StripeVendor
  end

  module StripeVendor
    SUPPORTED_COUNTRIES = {
        "US":"United States",
        "AU":"Australia",
        "AT":"Austria",
        "BE":"Belgium",
        "BR":"Brazil ",
        "CA":"Canada",
        "DK":"Denmark",
        "FI":"Finland",
        "FR":"France",
        "DE":"Germany",
        "HK":"Hong Kong",
        "IE":"Ireland",
        "JP":"Japan",
        "LU":"Luxembourg",
        "MX":"Mexico",
        "NL":"Netherlands",
        "NZ":"New Zealand",
        "NO":"Norway",
        "SG":"Singapore",
        "ES":"Spain",
        "SE":"Sweden",
        "CH":"Switzerland",
        "GB":"United Kingdom",
        "IT":"Italy",
        "PT":"Portugal"
    }
    module Customer

      def customer_info(customer_id)
        return nil if customer_id.blank?
        Stripe::Customer.retrieve(customer_id)
      end

      def add_customer(email)
        customer = Stripe::Customer.create(
            email:  email
        )
        customer.id
      end

      def get_sources(customer_id)
        customer_info(customer_id)&.sources
      end

      def get_source(customer_id, account_id)
        get_sources(customer_id)&.retrieve(account_id)
      end

      def set_source(customer_id, source_token)
        bank_account = get_sources(customer_id)&.create({source: source_token})
        bank_account&.id
      end
    end

    module Freelancer

      def account_info(merchant_id)
        return nil if merchant_id.blank?
        Stripe::Account.retrieve(merchant_id)
      end

      def update_account(merchant_id, legal_entity)
        return nil if merchant_id.blank? || legal_entity.blank? || (account_info = account_info(merchant_id)).blank?
        account_info.legal_entity = legal_entity_formatter(legal_entity)
      end

      def upload_verification_doc(merchant_id, file_path)
        return nil if merchant_id.blank?
        Stripe::FileUpload.create(
            {
                purpose: 'identity_document',
                file: File.new(file_path)
            },
            {stripe_account: merchant_id}
        )
      end

      def add_account(email, country)
        acct = Stripe::Account.create(
            type: 'custom',
            country: country,
            email: email,
            payout_schedule: {interval: 'manual'}
        )
        acct
      end

      def legal_entity_formatter(legal_entity)
        { 
          "dob": dob_formatter(legal_entity),
          "type": legal_entity.type,
          "address": address_formatter(legal_entity),
          "last_name": legal_entity.last_name,
          "first_name": legal_entity.first_name,
          "ssn_last_4": legal_entity.ssn_last_4,
          "verification": verification_formatter(legal_entity),
          "business_name": legal_entity.business_name,
          "business_tax_id": legal_entity.business_tax_id,
          "personal_address": personal_address_formatter(legal_entity),
          "personal_id_number": legal_entity.personal_id_number
        }
      end
      
      def personal_address_formatter(legal_entity)
        {
          "city": legal_entity.personal_address_city,
          "line1": legal_entity.personal_address_line1,
          "postal_code": legal_entity.personal_address_postal_code
        }
      end
      
      def verification_formatter(legal_entity)
        {
          "document": legal_entity.verification_document
        }
      end

      def dob_formatter(legal_entity)
        {
          "day": legal_entity.dob_day,
          "year": legal_entity.dob_year, 
          "month": legal_entity.dob_month
        }
      end

      def address_formatter(legal_entity)
        {
          "city": legal_entity.address_city,
          "line1": legal_entity.address_line1,
          "state": legal_entity.address_state,
          "country": legal_entity.address_country,
          "postal_code": legal_entity.address_postal_code
        }
      end
    end
  end
end
