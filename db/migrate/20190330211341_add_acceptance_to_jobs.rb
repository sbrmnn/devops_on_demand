class AddAcceptanceToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :acceptance, :boolean
  end
end
