class Freelancers::JobApprovalsController < ApplicationController
  def update
    @job = Job.find(params[:id]).lock!
    if @job.canceled.blank?
      if jobs_params[:canceled].to_b
        CancelJob.call(@job)
      else
        jobs_params[:acceptance].to_b ? ApproveJob.call(@job) : RejectJob.call(@job)
      end
    end
  end


  private

  def jobs_params
    whitelist_params(params, :job_approvals)
  end
end
