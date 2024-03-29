class Users::FreelancersController < ApplicationController
  before_action :authenticate_user!
  before_action :user



  def index
  end

  def create
    @freelancer = user.build_freelancer(freelancer_params)
    @freelancer.save
  end

  def show
  end

  def update
    @freelancer = user.freelancer
    @freelancer.update_attributes(freelancer_params)
  end

  def destroy
  end

  private

  def freelancer_params
    whitelist_params(params, :freelancer)
  end
end
