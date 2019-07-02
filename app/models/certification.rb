class Certification < ApplicationRecord
  belongs_to :product
  validates_uniqueness_of :certification_name_id, scope: :product_id
  validates_presence_of :vendor_identifier
  belongs_to :certification_name
end
