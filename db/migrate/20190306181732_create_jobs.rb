class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.belongs_to :user
      t.belongs_to :freelancer
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
