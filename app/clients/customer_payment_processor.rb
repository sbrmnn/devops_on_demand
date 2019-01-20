class CustomerPaymentProcessor
  extend PaymentProcessorAdapter::Customer.current_adapter

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def get_sources
    klass.get_sources(merchant_id)
  end

  def get_source
    klass.get_source(merchant_id, bank_id)
  end

  private

  def klass
    self.class
  end
end