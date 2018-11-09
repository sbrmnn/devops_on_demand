class AddIndexChatroomAndUsersToChatroomUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :chatroom_users, [:user_id, :chatroom_id], unique: true
  end
end
