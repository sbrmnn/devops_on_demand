class Users::JobsController < ApplicationController
  before_action :user
  layout 'profile'

  def show
  end

  def create
    @job = Job.new(job_params)
    @user.jobs << @job
  end

  protected

  def job_params
    whitelist_params(params, :job)
  end

end
