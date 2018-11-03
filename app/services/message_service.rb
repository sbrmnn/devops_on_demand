class MessageService
  def initialize(chatroom_id, body, user_who_created_msg)
    @chatroom_id = chatroom_id
    @body = body
    @user = user_who_created_msg
  end

  def broadcast
    message = Message.new(chatroom_id: @chatroom_id, body: @body, user: @user)
    if message.save
      ActionCable.server.broadcast "room_channel_#{message.chatroom_id}", message.as_json
    else
      Rails.logger.error "Message Service Error chatroom_id: #{@chatroom_id.id}, model_error: #{message.errors.messages}"
    end
  end
end