class AddTitleToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :title, :string
  end
end
