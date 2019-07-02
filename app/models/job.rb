class Job < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :transactions
  has_many :credit_cards, through: :user
  attr_accessor :front_end_token, :name, :line1, :line2, :city, :state, :zip, :country
  validates_presence_of :description, :hours, :from
  validate :check_for_credit_card, on: :create
  validate :validate_total, on: :create
  before_save :create_credit_card





  def check_for_credit_card
    if user.try(:credit_cards).blank? && front_end_token.blank?
      errors.add(:front_end_token, :blank, message: "cannot be blank")
    end
  end

  def validate_total
    if hours && (hours * product.rate * 100 != total)
      errors.add(:total, :error, message: "error")
    end
  end

  def create_credit_card
    if front_end_token.present?
      user_credit_cards = user.credit_cards
      user_credit_cards << CreditCard.new(front_end_token: front_end_token, name: name, line1: line1, line2: line2, city: city, state: state, zip: zip, country: country)
    end
  end
end
