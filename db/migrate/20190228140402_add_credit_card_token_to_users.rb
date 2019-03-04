class AddCreditCardTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users ,:credit_card_token, :string
  end
end
