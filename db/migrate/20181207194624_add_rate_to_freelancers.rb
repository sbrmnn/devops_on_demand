class AddRateToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :rate, :integer, default: 30, null: false
  end
end
