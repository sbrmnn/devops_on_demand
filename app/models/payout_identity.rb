class PayoutIdentity < ApplicationRecord
  belongs_to :freelancer
  has_one :legal_entity
  accepts_nested_attributes_for :legal_entity, reject_if: :all_blank, allow_destroy: true
end
