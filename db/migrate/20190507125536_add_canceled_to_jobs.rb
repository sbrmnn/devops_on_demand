class AddCanceledToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :canceled, :boolean, default: false
  end
end
