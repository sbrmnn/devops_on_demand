class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.belongs_to :user
      t.belongs_to :freelancer
      t.text :description
      t.decimal :hours, precision: 10, scale: 2
      t.string :credit_card_transaction
      t.date :from
      t.date :to
      t.timestamps
    end
  end
end
