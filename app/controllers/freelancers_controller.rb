class FreelancersController < ApplicationController
  layout 'profile', only: :show

  def index
    if user_signed_in?
      redirect_to dashboard_url
    end
  end

  def show
    freelancer_obj = Freelancer.find(params[:id])
    @freelancer = FreelancerPresenter.new(freelancer_obj)
  end
end
