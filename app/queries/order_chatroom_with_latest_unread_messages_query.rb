class OrderChatroomWithLatestUnreadMessagesQuery
  def self.call(relation=Chatroom.all)
    #TODO - Right now we are sorting by id. Need to sort my chatroom with latest recipient message.
    relation.order(:id)
  end
end