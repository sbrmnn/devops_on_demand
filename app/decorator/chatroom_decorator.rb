class ChatroomDecorator

  def initialize(chatroom, curr_user)
    @chatroom = chatroom
    @user = curr_user
  end

  def recipient
    user = @chatroom.users.where.not(id: @user.id).first
    "#{user.try(:first_name)} #{user.try(:last_name)} "
  end

  def new_message?
    if last_message.present?
      last_message.user_id != @user.id
    else
      false
    end
  end

  def new_message_time
    last_message.try(:created_at).try{|lm| lm.strftime("%m/%d/%Y")}
  end

  def last_message
    @chatroom.messages.last
  end
end