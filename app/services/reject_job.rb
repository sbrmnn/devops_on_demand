class RejectJob
  include Callable


  def initialize(job)
    @job = job
  end

  def call
    @job.update_attributes(acceptance: false)
    @job.reload
  end
end
