class Skill < ApplicationRecord
  belongs_to :freelancer
  serialize :types
end
