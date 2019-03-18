class CustomerPaymentProcessor

  attr_reader :user

  def initialize(user)
    @user = user
  end


  def customer_info
    if stripe_id.blank?
      customer = add_customer(user.email)
      user.update_attributes(stripe_id: customer.id)
      return customer
    end
    Stripe::Customer.retrieve(user.stripe_id)
  end

  def get_sources
    customer_info&.sources
  end

  def get_source(account_id)
    get_sources&.retrieve(account_id)
  end

  def set_source(source_token)
    get_sources&.create({source: source_token})
  end

  def stripe_id
    user.stripe_id
  end

  private

  def add_customer(email)
    Stripe::Customer.create(
        email:  email
    )
  end
end