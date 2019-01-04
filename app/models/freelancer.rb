class Freelancer < ApplicationRecord
  searchkick
  belongs_to :user
  has_many :educations, dependent: :destroy
  has_many :work_experiences, dependent: :destroy
  has_one :skill, dependent: :destroy
  has_many :certifications, dependent: :destroy

  validates_presence_of :headline
  validates_presence_of :location
  validates_presence_of :about_me

  validates :rate, numericality: { only_integer: true, greater_than_or_equal_to: 30 }
  validates_presence_of :profile_photo
  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :work_experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :skill, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :certifications, reject_if: :all_blank, allow_destroy: true

  before_save :create_user_name

  def search_data
    attributes.merge(
        skill: skill(&:types),
        achievements: work_experiences(&:achievements),
    )
  end

  def create_user_name
    self.user_name = UserPresenter.new(self.user).full_name
  end
end
