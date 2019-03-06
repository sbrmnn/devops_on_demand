class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.belongs_to :user
      t.boolean :newsletter_subscription, default: true
      t.boolean :chat_notification_subscription, default: true
      t.timestamps
    end
  end
end
