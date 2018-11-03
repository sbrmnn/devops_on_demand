class ChatroomUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
    redirect_to @chatroom
  end

  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
    redirect_to chatrooms_path
  end
end
