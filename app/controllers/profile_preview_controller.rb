class ProfilePreviewController < ApplicationController
  layout 'profile'
  before_action :authenticate_user!
  include StrongParameterizable

  def index
    freelancer = Freelancer.new(freelancer_params)
    freelancer.user_id = current_user.id
    @freelancer =  FreelancerPresenter.new(freelancer)
  end

  def freelancer_params
    whitelist_params(params, :freelancer, true)
  end
end
