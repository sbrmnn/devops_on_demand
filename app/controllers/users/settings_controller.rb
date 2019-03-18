class Users::SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :user


  def update
    @setting = user.setting
    @setting.update_attributes(setting_params)
  end


  private

  def setting_params
    whitelist_params(params, :setting)
  end
end
