class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :credit_card
      t.belongs_to :job
      t.string :merchant_id
      t.integer :amount
      t.integer :amount_refunded
      t.belongs_to :freelancer
      t.belongs_to :user
      t.timestamps
    end
  end
end
