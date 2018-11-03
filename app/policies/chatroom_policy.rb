class ChatroomPolicy

  def initialize(user_id, chatroom_id)
    @chatroom = Chatroom.find(chatroom_id)
    @user = User.find(user_id)
  end


  def can_access?
    ChatroomUser.where(chatroom: @chatroom, user: @user).any?
  end
end