class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = UserPresenter.find(current_user.id)
  end
end
