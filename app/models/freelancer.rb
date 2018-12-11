class Freelancer < ApplicationRecord
  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :work_experiences, dependent: :destroy
  has_one :skill, dependent: :destroy
  has_many :certifications, dependent: :destroy

  attr_accessor :skills

  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :work_experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :skill, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :certifications, reject_if: :all_blank, allow_destroy: true
end
