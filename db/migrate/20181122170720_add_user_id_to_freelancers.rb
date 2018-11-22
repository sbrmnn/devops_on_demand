class AddUserIdToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :user_id, :integer
  end
end
