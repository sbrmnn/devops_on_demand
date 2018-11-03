class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @chatrooms =  current_user.chatrooms
  end
end
