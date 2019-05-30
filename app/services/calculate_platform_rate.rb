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
     commission = 0
    case rate
      when (100..Float::INFINITY)
        commission = 7.5 + 4 + ((rate-50) * 0.15)
      when (50...100)
        commission = 7.5 + ((rate - 30) * 0.20)
      else
        commission =  rate * 0.25
    end
     (rate + commission).ceil
   end
  end