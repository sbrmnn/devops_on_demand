class CustomerPaymentProcessor

  attr_reader :user

  def initialize(user)
    @user = user
  end


  def customer_info(customer_id)
    return nil if customer_id.blank?
    Stripe::Customer.retrieve(customer_id)
  end

  def add_customer(email)
    customer = Stripe::Customer.create(
        email:  email
    )
    customer.id
  end

  def get_sources(customer_id)
    customer_info(customer_id)&.sources
  end

  def get_source(customer_id, account_id)
    get_sources(customer_id)&.retrieve(account_id)
  end

  def set_source(customer_id, source_token)
    bank_account = get_sources(customer_id)&.create({source: source_token})
    bank_account&.id
  end
end