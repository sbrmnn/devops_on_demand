class CreateCloudServices < ActiveRecord::Migration[5.1]
  def change
    create_table :cloud_services do |t|
      t.string :name
      t.string :provider
      t.timestamps
    end
  end
end
