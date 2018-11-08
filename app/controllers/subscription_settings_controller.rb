class SubscriptionSettingsController < ApplicationController
  def index
    @user = User.find_by(email: params[:email], unsub_token: params[:token])
  end
end
