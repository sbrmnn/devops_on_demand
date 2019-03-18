class CreditCard < ApplicationRecord
  belongs_to :user
  before_save :insert_card_to_customer_account
  attr_accessor :front_end_token

  def insert_card_to_customer_account
    if front_end_token.present?
      source = CustomerPaymentProcessor.new(User.find(user_id)).set_source(front_end_token)
      self.token = source.id
      self.last_4 = source.last4
    end
  end
end
