class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.eager_load(:jobs).eager_load(:setting).eager_load(:chatrooms).where(id: current_user.id).first
  end
end
