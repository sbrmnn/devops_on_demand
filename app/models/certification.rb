class Certification < ApplicationRecord
  belongs_to :freelancer
  validates_uniqueness_of :certification_name_id, scope: :freelancer_id
  has_one :certification_name
end
