class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = UserPresenter.new(current_user)
  end
end
