class Job < ApplicationRecord
  belongs_to :user
  belongs_to :freelancer
  has_one :credit_card, through: :user
end
