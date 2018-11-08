class AddColumnChatNotificationSubscriptionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :chat_notification_subscription, :boolean, default: true
  end
end
