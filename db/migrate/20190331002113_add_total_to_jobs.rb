class AddTotalToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :total, :integer
  end
end
