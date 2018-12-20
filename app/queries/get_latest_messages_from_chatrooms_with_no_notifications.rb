class GetLatestMessagesFromChatroomsWithNoNotifications
  def self.call(created_at_time_limit=100.years.ago)
    Message.select('distinct on (chatroom_id) *').order("chatroom_id, created_at desc").where("notification_sent = 'f' and created_at > ?", created_at_time_limit)
  end
end
