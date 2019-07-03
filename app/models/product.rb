class Product < ApplicationRecord
  searchkick
  attr_accessor :lang_used
  belongs_to :user
  before_save :calculate_platform_rate
  before_save :enter_tags
  has_many :tags, as: :taggable



  def enter_tags
    if lang_used.present?
      lang_used.split(',').each do |l|
        if self.tags.exists?
        self.tags.where(name: l).first_or_create
        else
          self.tags << Tag.new(name: l)
        end
      end
    end
  end

  def calculate_platform_rate
    self.platform_cost = CalculatePlatformRate.call(cost) if platform_cost.blank? || cost_changed?
  end
end
