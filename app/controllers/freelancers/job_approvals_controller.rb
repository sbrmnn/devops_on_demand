class Freelancers::JobApprovalsController < ApplicationController
  def update
    @job = Job.find(params[:id])
    if jobs_params[:acceptance].to_b
      ApproveJob.call(@job)
    else
      RejectJob.call(@job)
    end
  end


  private

  def jobs_params
    whitelist_params(params, :job_approvals)
  end
end
