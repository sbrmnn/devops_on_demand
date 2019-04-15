class RemoveColumnTypesFromSkills < ActiveRecord::Migration[5.1]
  def change
    remove_column :skills, :types, :text
  end
end
