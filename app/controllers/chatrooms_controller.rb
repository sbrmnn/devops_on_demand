class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_product



  def create
    @chatroom = GetChatroomWithUsers.call(current_user.id, chatroom_params[:product_user]).first
    if @chatroom.blank?
     @chatroom = Chatroom.create
     @chatroom.chatroom_users << [ChatroomUser.new(user: current_user, chatroom: @chatroom), [ChatroomUser.new(user: User.find_by_id(chatroom_params[:product_user]), chatroom: @chatroom)]]
    end
  end

  private

  def get_product
    @product = User.find_by(id: chatroom_params[:product_user]).product
  end

  def chatroom_params
    whitelist_params(params, :chatrooms)
  end
end
