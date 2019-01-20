class PayoutIdentity < ApplicationRecord
  belongs_to :freelancer
  has_one :legal_entity
end
