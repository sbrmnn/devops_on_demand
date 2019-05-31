class RejectJob
  include Callable


  def initialize(job)
    @job = job
  end

  def call
    @job.with_lock do
      @job.update_attributes(acceptance: false)
    end
    @job.reload
  end
end
