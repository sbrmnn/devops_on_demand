class UserPresenter
  extend Forwardable

  def_delegators :freelancer, :about_me, :about_me=, :headline, :headline=

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def chatrooms
    @chatroom_presenters ||= ordered_chatrooms.map{|cr| ChatroomPresenter.new(cr)}
  end

  def freelancer
    user.freelancer || user.build_freelancer
  end


  private

  def ordered_chatrooms
    @ordered_chatrooms ||= OrderChatroomWithLatestUnreadMessagesQuery.call(user.chatrooms)
  end
end
