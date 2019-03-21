class AddColumnSourceControlUrlToFreelancers < ActiveRecord::Migration[5.1]
  def change
    add_column :freelancers, :source_control_url, :string
  end
end
