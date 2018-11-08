class SubscriptionSettingsController < ApplicationController


  def show
    select_columns = [:id, :chat_notification_subscription, :newsletter_subscription]
    @user = User.select(select_columns).find_by(email: params[:email], unsub_token: params[:unsub_token])
    raise ActionController::RoutingError.new('Not Found') if @user.blank?
  end

  def update
    @user = User.find_by(email: params[:user][:email], unsub_token: params[:user][:unsub_token])
    if @user.update_attributes({newsletter_subscription: params[:user][:newsletter_subscription], chat_notification_subscription: params[:user][:chat_notification_subscription]})
      flash[:success] = {header: t('saved'), message: t('subscription_save_alert')}
    else
      flash[:error] = {header: t('error'), message: t('subscription_save_error')}
    end
    redirect_to action: :show, email: params[:user][:email], unsub_token: params[:user][:unsub_token]
  end
end
