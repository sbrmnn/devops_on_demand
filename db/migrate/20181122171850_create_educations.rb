class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations do |t|
      t.string :name
      t.integer :graduation_year
      t.belongs_to :product
      t.timestamps
    end
  end
end
