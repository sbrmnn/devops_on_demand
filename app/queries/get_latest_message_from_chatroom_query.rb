class GetLatestMessageFromChatroomQuery
  def self.call(chatroom, msg_created_at_time_limit=100.years.ago )
    chatroom.messages.where("created_at > ?",  msg_created_at_time_limit).last
  end
end