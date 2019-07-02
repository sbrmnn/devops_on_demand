class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.belongs_to :product
      t.text :types, default: [].to_yaml
      t.timestamps
    end
  end
end
