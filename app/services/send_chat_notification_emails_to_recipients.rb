class SendChatNotificationEmailsToRecipients

  include Callable

  def initialize
    @created_at_time_limit = (ENV['CHAT_EMAIL_INTERVAL_IN_MINUTES'].to_i + 5).minutes.ago
  end

  def call
    latest_chatroom_messages_with_no_notifications.each do |m|
      chatroom_id =  m.chatroom.id
      message_body = m.body
      messenger_first_name = m.user.first_name
      emailable_message_recipients(m).each do |er|
        begin
          ChatNotificationMailer.send_email(er, messenger_first_name, chatroom_id, message_body).deliver
          m.update_attribute(:notification_sent, true)
        rescue Exception => e
          Rails.logger.error "Email Error: SendChatNotificationEmailsToRecipients #{e.message}"
        end
      end
    end
  end

  private

  def latest_chatroom_messages_with_no_notifications
    GetLatestMessagesFromChatroomsWithNoNotifications.call(@created_at_time_limit)
  end

  def emailable_message_recipients(m)
    m.chatroom.users.where.not(id: m.user_id).where(chat_notification_subscription: true)
  end
end
