class AddSkillsToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :skills, :jsonb
  end
end
