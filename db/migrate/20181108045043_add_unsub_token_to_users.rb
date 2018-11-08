class AddUnsubTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :unsub_token, :string
  end
end
