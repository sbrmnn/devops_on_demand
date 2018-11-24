class UserPresenter < User
  extend Forwardable

  def_delegators :freelancer, :about_me, :about_me=, :headline, :headline=

  def chatroom_presenters
    @chatroom_presenters ||= ordered_chatrooms
  end

  private

  def ordered_chatrooms
    @ordered_chatrooms ||= OrderChatroomWithLatestUnreadMessagesQuery.call(cr_presenters)
  end

  def cr_presenters
    @cr_presenters ||= ChatroomPresenter.where(id: chatrooms.pluck(:id))
  end
end
