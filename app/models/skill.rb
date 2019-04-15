class Skill < ApplicationRecord
  belongs_to :freelancer
  belongs_to :cloud_service
  serialize :types
end
