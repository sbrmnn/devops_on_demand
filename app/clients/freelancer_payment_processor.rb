class FreelancerPaymentProcessor

  attr_reader :current_vendor

  def initialize(freelancer)
    raise "Input must be a Freelancer object."  unless freelancer.class == Freelancer
    raise "Freelancer record must be persisted" unless freelancer.persisted?
    @freelancer = freelancer
    include_vendor_interface_methods
  end

  def self.adapter
    StripeVendor
  end

  def include_vendor_interface_methods
    self.class.send :include, self.class.adapter
  end

  module StripeVendor
    attr_reader :freelancer, :merchant_id

    def self.supported_countries
      {
          "US":"United States",
          "AU":"Australia",
          "AT":"Austria",
          "BE":"Belgium",
          "CA":"Canada",
          "DK":"Denmark",
          "FI":"Finland",
          "DE":"Germany",
          "IE":"Ireland",
          "LU":"Luxembourg",
          "NL":"Netherlands",
          "NZ":"New Zealand",
          "NO":"Norway",
          "ES":"Spain",
          "SE":"Sweden",
          "CH":"Switzerland",
          "GB":"United Kingdom",
          "IT":"Italy",
          "PT":"Portugal"
      }
    end

    def self.supported_currencies
       {
           "US": :usd,
           "AU": :aud,
           "AT": :eur,
           "BE": :eur,
           "CA": :cad,
           "DK": :dkk,
           "FI": :eur,
           "DE": :eur,
           "IE": :eur,
           "LU": :eur,
           "NL": :eur,
           "NZ": :nzd,
           "NOK": :nok,
           "ES": :eur,
           "SE": :sek,
           "CH": :chf,
           "GB": :gpb,
           "IT": :eur,
           "PT": :eur
       }
    end

    def self.confirm_webhook_signature(request)
      payload = request.body.read
      signature = request.env['HTTP_STRIPE_SIGNATURE']
      Stripe::Webhook.construct_event(
          payload, signature, ENV['STRIPE_WEBHOOK_SECRET']
      )
    end

    def settlement_currency
      self.class.adapter.supported_currencies[freelancer.location.to_sym]
    end

    def upload_verification_doc(file_path)
      file_upload = Stripe::FileUpload.create(
          {
              purpose: 'identity_document',
              file: File.new(file_path)
          },
          {stripe_account: merchant_id}
      )
      file_upload
    end

    def update_payout_identity(payout_identity)
      return nil if merchant_id.blank? || payout_identity.blank? || account_info.blank?
      update_payout_identity_on_account(payout_identity)
    end

    def update_legal_entity(legal_entity)
      return nil if merchant_id.blank? || legal_entity.blank? || account_info.blank?
      update_legal_entity_on_account(legal_entity)
    end

    def payout_identity_missing_fields(fields_needed=nil)
      cache = Rails.cache.read(missing_field_cache_key) || []
      unless fields_needed.nil?
        Rails.cache.write(missing_field_cache_key, fields_needed)
        MissingFieldsPayoutIdentityChannel.broadcast(fields_needed, freelancer.id)
        return Rails.cache.read(missing_field_cache_key)
      end
      cache
    end

    def account_info
      return nil if merchant_id.blank?
      @account_info ||= Stripe::Account.retrieve(merchant_id)
    end

    private

    def update_payout_identity_on_account(payout_identity)
      if payout_identity.external_account.present?
        account_info.external_account = payout_identity.external_account
        account_info.save
      end
    end

    def update_legal_entity_on_account(legal_entity)
      account_info.legal_entity.dob.day   = legal_entity.dob_day if legal_entity.dob_day.present?
      account_info.legal_entity.dob.year  = legal_entity.dob_year if legal_entity.dob_year.present?
      account_info.legal_entity.dob.month = legal_entity.dob_month if legal_entity.dob_month.present?
      account_info.legal_entity.type      = legal_entity.entity_type if legal_entity.entity_type.present?
      account_info.legal_entity.address.city = legal_entity.address_city if legal_entity.address_city.present?
      account_info.legal_entity.address.line1 = legal_entity.address_line1 if legal_entity.address_line1.present?
      account_info.legal_entity.address.state = legal_entity.address_state if legal_entity.address_state.present?
      account_info.legal_entity.address.country = country(legal_entity)
      account_info.legal_entity.address.postal_code = legal_entity.address_postal_code if legal_entity.address_postal_code.present?
      account_info.legal_entity.last_name = legal_entity.last_name if legal_entity.last_name.present?
      account_info.legal_entity.first_name = legal_entity.first_name if legal_entity.first_name.present?
      account_info.legal_entity.ssn_last_4 = legal_entity.ssn_last_4 if legal_entity.ssn_last_4.present?
      account_info.legal_entity.business_name = legal_entity.business_name if legal_entity.business_name.present?
      account_info.legal_entity.business_tax_id = legal_entity.business_tax_id if legal_entity.business_tax_id.present?
      account_info.legal_entity.personal_id_number = legal_entity.personal_id_number if legal_entity.personal_id_number.present?
      account_info.legal_entity.personal_address.city = legal_entity.personal_address_city if legal_entity.personal_address_city.present?
      account_info.legal_entity.personal_address.line1 = legal_entity.personal_address_line1 if legal_entity.personal_address_line1.present?
      account_info.legal_entity.personal_address.postal_code = legal_entity.personal_address_postal_code if legal_entity.personal_address_postal_code.present?
      account_info.legal_entity.verification.document = upload_verification_doc(legal_entity.verification_image.path) if legal_entity.verification_image.try(:path).present?
      account_info.save
      account_info
    end

    def country(legal_entity)
      if FreelancerPaymentProcessor.adapter.supported_countries.keys.include?(legal_entity.address_country)
        legal_entity.address_country
      else
        freelancer.location
      end
    end

    def get_legal_entity_value(field)
      if field.present?
        field
      else
        nil
      end
    end

    def merchant_id
      @merchant_id ||= (freelancer.merchant_id || add_account.id)
    end

    def missing_field_cache_key
      "#{merchant_id}_missing_fields"
    end

    def add_account
      acct = Stripe::Account.create(
          type: 'custom',
          country: freelancer.location,
          email: freelancer.user.email,
          payout_schedule: {interval: 'manual'}
      )
      account_id = acct.id
      freelancer.update_attribute(:merchant_id, account_id )
      acct
    end
  end
end