class AddAboutMeToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :about_me, :string
  end
end
