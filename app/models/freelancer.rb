class Freelancer < ApplicationRecord
  belongs_to :user
  has_many :educations
  has_many :work_experiences
  has_many :skills
  has_many :certifications, inverse_of: :freelancers
  accepts_nested_attributes_for :certifications, reject_if: :all_blank, allow_destroy: true
end
