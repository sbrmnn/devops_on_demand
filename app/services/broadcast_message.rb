class BroadcastMessage
  include Callable

  def initialize(message)
    @message = message
  end

  def call
    {notificationType: :chatroom, payload: @message.as_json}
    ActionCable.server.broadcast "room_channel_#{@message.chatroom_id}", @message.as_json
  end
end