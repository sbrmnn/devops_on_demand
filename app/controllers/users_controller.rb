class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @chatrooms =   OrderChatroomWithLatestUnreadMessagesQuery.call(current_user.chatrooms)
    @chatroom_presenters = @chatrooms.map{|cr| ChatroomPresenter.new(cr)}
  end
end
