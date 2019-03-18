class AddLast4ToCreditCard < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :last_4, :string
  end
end
