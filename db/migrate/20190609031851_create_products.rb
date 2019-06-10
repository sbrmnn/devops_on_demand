class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer "user_id"
      t.string "headline"
      t.string "description"
      t.integer "cost", default: 10, null: false
      t.string "photo"
      t.string "merchant_id"
      t.integer "platform_cost"
      t.timestamps
    end
  end
end
