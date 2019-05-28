class AddPlatformRateToFreelancer < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :platform_rate, :integer
  end
end
