class AddNotificationSentToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :notification_sent, :boolean, default: false
  end
end
