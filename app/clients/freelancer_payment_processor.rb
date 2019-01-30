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
      freelancer.legal_entity.update_attribute(:verification_document, file_upload["id"])
      file_upload
    end

    def update_account(legal_entity)
      return nil if merchant_id.blank? || legal_entity.blank? || account_info.blank?
      account_info.legal_entity = legal_entity_formatter(legal_entity)
      account_info.legal_entity.verification.document = legal_entity.verification_document
      Rails.cache.write(missing_field_cache_key, nil)
      account_info.save
    end

    def merchant_id
      @merchant_id ||= (freelancer.merchant_id || add_account.id)
    end

    def payout_identity_missing_fields
      cache = Rails.cache.read(missing_field_cache_key)
      if cache.nil?
        fields_needed = account_info.verification.fields_needed
        Rails.cache.write(missing_field_cache_key, fields_needed)
        return Rails.cache.read(missing_field_cache_key)
      end
      cache
    end

    def account_info
      return nil if merchant_id.blank?
      @account_info ||= Stripe::Account.retrieve(merchant_id)
    end

    def legal_entity_formatter(legal_entity)
      {
        "dob": dob_formatter(legal_entity),
        "type": legal_entity.type,
        "address": address_formatter(legal_entity),
        "last_name": legal_entity.last_name,
        "first_name": legal_entity.first_name,
        "ssn_last_4": legal_entity.ssn_last_4,
        "business_name": legal_entity.business_name,
        "business_tax_id": legal_entity.business_tax_id,
        "personal_address": personal_address_formatter(legal_entity),
        "personal_id_number": legal_entity.personal_id_number
      }
    end

    private

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

    def personal_address_formatter(legal_entity)
      {
        "city": legal_entity.personal_address_city,
        "line1": legal_entity.personal_address_line1,
        "postal_code": legal_entity.personal_address_postal_code
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