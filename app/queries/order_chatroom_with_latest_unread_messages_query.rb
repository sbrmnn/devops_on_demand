class OrderChatroomWithLatestUnreadMessagesQuery


  def self.call(collection=ChatroomPresenter.all)
     check_type_for_collection(collection)
     #TODO - Right now we are sorting by id. Need to sort my chatroom with latest recipient message.
     collection.order(:id)
  end

  class << self
    private

    def check_type_for_collection(collection)
      if collection.try(:klass) != Chatroom && collection.try(:klass) != ChatroomPresenter
        raise "Argument should be a collection of Chatroom or of ChatroomPresenter type."
      else
        true
      end
    end
  end
end