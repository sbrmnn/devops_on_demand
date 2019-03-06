class SubscriptionSettingsController < ApplicationController
  layout 'subscription'

  def show
    select_columns = [:id, :chat_notification_subscription, :newsletter_subscription]
    @user = User.select(select_columns).find_by(email: params[:email], unsub_token: params[:unsub_token])
    raise ActionController::RoutingError.new('Not Found') if @user.blank?
  end

  def update
    @user = User.find_by(email: params[:setting][:email], unsub_token: params[:setting][:unsub_token])
    @setting = @user.setting
    @setting.update_attributes({newsletter_subscription: params[:setting][:newsletter_subscription], chat_notification_subscription: params[:setting][:chat_notification_subscription]})
  end
end
