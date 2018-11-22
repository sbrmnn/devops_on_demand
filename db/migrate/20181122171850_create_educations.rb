class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations do |t|
      t.string :name
      t.integer :graduation_year
      t.belongs_to :freelancers
      t.timestamps
    end
  end
end
