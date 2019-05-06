class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_freelancer

  def create
    chatrooms = current_user.chatrooms
    @chatroom = ChatroomUser.find_by(chatroom: chatrooms, user_id: chatroom_params[:freelancer_user]).try(:chatroom)
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
