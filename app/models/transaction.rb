class Transaction < ApplicationRecord
  belongs_to  :credit_card
  belongs_to  :job
  belongs_to  :freelancer
  belongs_to  :user
end
