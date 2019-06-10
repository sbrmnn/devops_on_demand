class Product < ApplicationRecord
  searchkick

  belongs_to :user
  before_save :calculate_platform_rate





  def calculate_platform_rate
    self.platform_cost = CalculatePlatformRate.call(cost) if platform_cost.blank? || cost_changed?
  end
end
