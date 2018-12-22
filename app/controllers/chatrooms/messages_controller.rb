class Chatrooms::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def show
    render json: @chatroom.messages
  end
end
