class ChatroomDecorator

  def initialize(chatroom)
    @chatroom = chatroom
  end

  def recipient
    user = @chatroom.users.where.not(id: last_message_user.id).first
    "#{user.try(:first_name)} #{user.try(:last_name)} "
  end

  def new_message?(user_id)
    if last_message.present?
      last_message.user_id != user_id
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

  def last_message_user
    @chatroom.messages.last.user
  end
end