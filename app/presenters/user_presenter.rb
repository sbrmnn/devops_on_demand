class UserPresenter < ApplicationPresenter

  def chatrooms
    @chatroom_presenters ||= ordered_chatrooms.map{|cr| ChatroomPresenter.new(cr)}
  end

  def freelancer
    subject.freelancer
  end


  private

  def ordered_chatrooms
    @ordered_chatrooms ||= OrderChatroomWithLatestUnreadMessagesQuery.call(subject.chatrooms)
  end
end
