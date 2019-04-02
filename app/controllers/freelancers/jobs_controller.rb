class Freelancers::JobsController < ApplicationController

  def update
    @job = current_user.freelancer.jobs.lock.find(params[:id]).update_attributes(jobs_params)
  end

  def jobs_params
    whitelist_params(params, :freelancer_job)
  end
end
