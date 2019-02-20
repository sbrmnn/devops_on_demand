class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel_#{params[:chatroom_id]}"
    reject unless user_can_access_chatroom?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = save_message(data['body'])
    if message.present?
      broadcast_message(message)
    end
  end

  private

  def user_can_access_chatroom?
    ChatroomPolicy.new(current_user, chatroom).can_access?
  end

  def save_message(body)
    message = Message.new(chatroom: chatroom, body: body, user: current_user)
    unless message.save
      Rails.logger.error "Message Save Error chatroom_id: #{params[:chatroom_id]}, model_error: #{message.errors.messages}"
      return nil
    end
    message
  end

  def broadcast_message(message)
     BroadcastMessage.call(message)
  end

  def chatroom
    @chatroom ||= Chatroom.find(params[:chatroom_id])
  end
end
