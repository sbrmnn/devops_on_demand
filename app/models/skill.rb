class Skill < ApplicationRecord
  belongs_to :freelancer
  belongs_to :cloud_service
  serialize :types
  validates_uniqueness_of :cloud_service_id, :scope => :freelancer_id
end
