class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_freelancer



  def create
    @chatroom = GetChatroomWithUsers.call(current_user_id, chatroom_params[:freelancer_user]).first
    if @chatroom.blank?
     @chatroom = Chatroom.create
     @chatroom.chatroom_users << [ChatroomUser.new(user: current_user, chatroom: @chatroom), [ChatroomUser.new(user: User.find_by_id(chatroom_params[:freelancer_user]), chatroom: @chatroom)]]
    end
  end

  private

  def get_freelancer
    @freelancer = User.find_by(id: chatroom_params[:freelancer_user]).freelancer
  end

  def chatroom_params
    whitelist_params(params, :chatrooms)
  end
end
