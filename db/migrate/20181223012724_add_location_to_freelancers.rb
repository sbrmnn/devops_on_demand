class AddLocationToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :location, :string
  end
end
