class GetLatestMessagesFromChatrooms
  def self.call(created_at_time_limit=100.years.ago)
    Message.select('distinct on (chatroom_id) *').order("chatroom_id, created_at desc").where("created_at > ?", created_at_time_limit)
  end
end
