class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.eager_load(:jobs, :setting, :chatrooms, :payout_identity, :freelancer, :credit_cards).where(id: current_user.id).first
  end
end
