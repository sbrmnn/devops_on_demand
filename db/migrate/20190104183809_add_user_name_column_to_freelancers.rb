class AddUserNameColumnToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :user_name, :string
  end
end
