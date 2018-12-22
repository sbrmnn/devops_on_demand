class Certification < ApplicationRecord
  belongs_to :freelancer
  validates_uniqueness_of :certification_name_id, scope: :freelancer_id
  validates_presence_of :vendor_identifier
  belongs_to :certification_name
end
