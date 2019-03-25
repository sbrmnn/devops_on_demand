class AddRelayUserNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :relay_user_name, :string
  end
end
