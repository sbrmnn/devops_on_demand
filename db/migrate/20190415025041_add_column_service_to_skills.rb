class AddColumnServiceToSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :skills, :cloud_service_id, :bigint
  end
end
