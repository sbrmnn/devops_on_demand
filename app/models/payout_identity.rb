class PayoutIdentity < ApplicationRecord
  belongs_to :freelancer
  has_one :legal_entity, dependent: :destroy
  accepts_nested_attributes_for :legal_entity, reject_if: :all_blank, allow_destroy: true
  before_save :update_payout_identity_with_payment_provider

  def update_payout_identity_with_payment_provider
    FreelancerPaymentProcessor.new(freelancer).update_payout_identity(self) if external_account_changed?
  end
end
