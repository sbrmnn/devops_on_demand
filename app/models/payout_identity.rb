class PayoutIdentity < ApplicationRecord
  belongs_to :product
  has_one :legal_entity, dependent: :destroy
  has_many :missing_payout_fields
  accepts_nested_attributes_for :legal_entity, reject_if: :all_blank, allow_destroy: true
  before_save :update_payout_identity_with_payment_provider

  def update_payout_identity_with_payment_provider
    ProductPaymentProcessor.new(product).update_payout_identity(self) if external_account_changed?
  end
end
