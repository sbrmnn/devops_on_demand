class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :credit_card
      t.bigint :job_id
      t.string :merchant_id
      t.integer :amount
      t.integer :amount_refunded
      t.belongs_to :product
      t.belongs_to :user
      t.timestamps
    end
    add_index(:transactions, [:job_id], unique: true)
  end
end
