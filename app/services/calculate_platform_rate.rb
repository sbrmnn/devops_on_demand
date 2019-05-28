class CalculatePlatformRate
  include Callable

  def initialize(rate)
    @rate = rate
  end


  def call
    platform_rate_algo(@rate)
  end


  private

  def platform_rate_algo(rate)
    (rate * 1.20).ceil
  end
end