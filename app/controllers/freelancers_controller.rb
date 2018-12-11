class FreelancersController < ApplicationController
  before_action :authenticate_user!
  layout 'profile', only: :show

  def index
  end

  def show
  end
end
