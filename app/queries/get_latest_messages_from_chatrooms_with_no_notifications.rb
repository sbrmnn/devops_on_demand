class GetLatestMessagesFromChatroomsWithNoNotifications
  def self.call(created_at_time_limit=100.years.ago)
    Message.latest_messages_by_chatroom.where("notification_sent = 'f' and created_at > ?", created_at_time_limit)
  end
end