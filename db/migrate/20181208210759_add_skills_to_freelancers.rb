class AddSkillsToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :skills, :json_b
  end
end
