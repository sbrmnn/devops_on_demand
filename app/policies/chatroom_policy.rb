class ChatroomPolicy
  attr_reader :chatroom, :user
  def initialize(user, chatroom)
    @chatroom = chatroom
    @user = user
  end

  def can_access?
    ChatroomUser.where(chatroom: chatroom, user: user).any?
  end
end
