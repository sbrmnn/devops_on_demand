class GetLatestMessageFromChatroomQuery
  def self.call(chatroom, msg_created_at_time_limit=100.years.ago )
    chatroom.messages.where("created_at > ?",  msg_created_at_time_limit).order(:id).last
  end
end