class LegalEntity < ApplicationRecord
  belongs_to :payout_identity
  has_one :product, through: :payout_identity
  attr_accessor :verification_image, :dob
  before_save :update_legal_entity_with_payment_provider


  def update_legal_entity_with_payment_provider
    account_info = ProductPaymentProcessor.new(product).update_legal_entity(self)
    self.dob_day   =  account_info.legal_entity.dob.day
    self.dob_year  = account_info.legal_entity.dob.year
    self.dob_month = account_info.legal_entity.dob.month
    self.entity_type = account_info.legal_entity.type
    self.address_city = account_info.legal_entity.address.city
    self.address_line1 =  account_info.legal_entity.address.line1
    self.address_state = account_info.legal_entity.address.state
    self.address_country = account_info.legal_entity.address.country
    self.address_postal_code = account_info.legal_entity.address.postal_code
    self.last_name = account_info.legal_entity.last_name
    self.first_name =  account_info.legal_entity.first_name
    self.business_name = account_info.legal_entity.business_name
    self.personal_address_city = account_info.legal_entity.personal_address.city
    self.personal_address_line1 =  account_info.legal_entity.personal_address.line1
    self.personal_address_postal_code = account_info.legal_entity.personal_address.postal_code
    self.verification_document =  account_info.legal_entity.verification.document
  end
end
