class UserPayment
  include Callable
  def initialize(user)
    @user = user
  end
end