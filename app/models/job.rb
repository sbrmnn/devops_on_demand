class Job < ApplicationRecord
  belongs_to :user
  belongs_to :freelancer
  has_many :transactions
  has_many :credit_cards, through: :user
  attr_accessor :front_end_token, :name, :line1, :line2, :city, :state, :zip, :country
  validates_presence_of :description, :hours, :from, :to
  validate :check_for_credit_card, :on => :create
  before_save :create_credit_card
  before_save :charge_credit_card

  def check_for_credit_card
    if user.credit_cards.blank? || front_end_token.blank?
      errors.add(:front_end_token, :blank, message: "cannot be blank")
    end
  end

  def create_credit_card
    if front_end_token.present?
      user_credit_cards = user.credit_cards
      user_credit_cards << CreditCard.new(front_end_token: front_end_token, name: name, line1: line1, line2: line2, city: city, state: state, zip: zip, country: country)
    end
  end

  def charge_credit_card
    credit_card = credit_cards.last
    if transactions.blank? && acceptance.present? && acceptance_changed? && credit_card.present?
      charge = CustomerPaymentProcessor.new(self.user).charge_source(total, "Job ##{self.id}")
      Transaction.create(credit_card: credit_card, job: self, merchant_id: charge.id, amount: charge.amount, amount_refunded: charge.amount_refunded, freelancer: freelancer, user: user)
    end
  end
end
