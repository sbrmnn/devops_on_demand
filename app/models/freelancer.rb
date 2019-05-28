class Freelancer < ApplicationRecord
  searchkick
  attr_accessor :cloud_service_array
  belongs_to :user, optional: true
  has_many :educations, dependent: :destroy
  has_many :work_experiences, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :cloud_services, through: :skills
  has_one :payout_identity
  has_one :legal_entity, through: :payout_identity
  has_many :certifications, dependent: :destroy
  has_many :certification_names, through: :certifications, dependent: :destroy
  has_many :jobs
  has_many :transactions
  validates_presence_of :headline
  validates_presence_of :location
  validates_presence_of :about_me
  validates :source_control_url, allow_blank: true ,format: { with: /(http|https):\/\/[a-zA-Z0-9\-\#\/\_]+[\.][a-zA-Z0-9\-\.\#\/\_]+/i }

  validates :rate, numericality: { only_integer: true, greater_than_or_equal_to: 30 }
  validates_presence_of :profile_photo
  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :work_experiences, reject_if: :all_blank, allow_destroy: true
  #accepts_nested_attributes_for :skill, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :certifications, reject_if: :all_blank, allow_destroy: true

  auto_strip_attributes :headline, :about_me, :source_control_url ,:rate, :location
  
  before_save :create_user_name
  before_save :create_skills


  before_save :calculate_platform_rate





  def search_data
    attributes.merge(
      achievements: work_experiences(&:achievements),
      cloud_services_ids:  cloud_services.map(&:id)
    )
  end



  def create_skills
    unless cloud_service_array.nil?
      skills_array = []
      self.cloud_service_array&.map{|l|
        skills_array  << Skill.new(cloud_service_id: l.to_i)
      }
      self.skills = skills_array
    end
  end

  def create_user_name
    self.user_name = UserPresenter.new(self.user).full_name if user.present?
  end


  def calculate_platform_rate
    self.platform_rate = CalculatePlatformRate.call(rate) if platform_rate.blank?
  end
end
