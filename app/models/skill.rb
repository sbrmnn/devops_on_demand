class Skill < ApplicationRecord
  belongs_to :product
  belongs_to :cloud_service
  serialize :types
  validates_uniqueness_of :cloud_service_id, :scope => :product_id
end
