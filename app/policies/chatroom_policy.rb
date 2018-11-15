class ChatroomPolicy

  def initialize(user_id, chatroom)
    @chatroom = chatroom
    @user = User.find(user_id)
  end

  def can_access?
    ChatroomUser.where(chatroom: @chatroom, user: @user).any?
  end
end
