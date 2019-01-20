class FreelancerPayment
  include Callable
  def initialize(freelancer)
    @freelancer = freelancer
  end
end