class FreelancersController < ApplicationController
  layout 'profile', only: :show
  before_action :authenticate_user!
  
  def index
  end

  def show
  end
end
