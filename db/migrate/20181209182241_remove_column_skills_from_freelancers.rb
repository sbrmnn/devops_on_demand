class RemoveColumnSkillsFromFreelancers < ActiveRecord::Migration[5.1]
  def change
    remove_column :freelancers, :skills, :jsonb
  end
end
