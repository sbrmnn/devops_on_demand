class RoomChannel < ApplicationCable::Channel
  def subscribed
     stream_from "room_channel_#{params[:chatroom_id]}"
     reject unless user_can_access_chatroom?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    broadcast_message(data['body'])
  end


  private

  def user_can_access_chatroom?
    ChatroomPolicy.new(current_user.id, params[:chatroom_id]).can_access?
  end

  def broadcast_message(body)
    MessageService.new(params[:chatroom_id], body, current_user).broadcast
  end
end
