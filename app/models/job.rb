class Job < ApplicationRecord
  belongs_to :user
  belongs_to :freelancer
  has_one :credit_card, through: :user
  attr_accessor :front_end_token, :name, :line1, :line2, :city, :state, :zip, :country
  after_save :create_credit_card
  validates_presence_of :description, :hours, :from, :to


  def create_credit_card
    if self.front_end_token.present?
      user_credit_card = user.credit_card
      if user_credit_card.present?
        user_credit_card.update_attributes(front_end_token: front_end_token, name: name, line1: line1, line2: line2, city: city, state: state, zip: zip, country: country)
      else
        CreditCard.create(front_end_token: front_end_token, name: name, line1: line1, line2: line2, city: city, state: state, zip: zip, country: country, user: user)
      end
    end
  end
end
