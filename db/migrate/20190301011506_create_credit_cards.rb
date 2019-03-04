class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.belongs_to :user
      t.string :token
      t.string :name
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.timestamps
    end
  end
end
