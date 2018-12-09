class Freelancer < ApplicationRecord
  belongs_to :user
  has_many :educations
  has_many :work_experiences
  has_many :skills
  has_many :certifications
  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :work_experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :skills, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :certifications, reject_if: :all_blank, allow_destroy: true
  attr_accessor :my_skills
end
