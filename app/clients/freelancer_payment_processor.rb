class FreelancerPaymentProcessor
  extend PaymentProcessorAdapter::current_adapter::Freelancer

  attr_reader :freelancer, :merchant_id, :bank_id

  def initialize(freelancer)
    @freelancer = freelancer
  end

  def upload_verification_doc(file_path)
    klass.upload_verification_doc(merchant_id, file_path)
  end

  def update_account(array)

  end

  def account_info
    klass.account_info(merchant_id)
  end

  def merchant_id
    @merchant_id ||= (freelancer.merchant_id || add_account.id)
  end

  def bank_id
    @bank_id ||= freelancer.payout_identity.try(:external_account)
  end

  private

  def add_account
    account = klass.add_account(freelancer.user.email, freelancer.location)
    account_id = account.id
    freelancer.update_attribute(:merchant_id, account_id )
    account
  end

  def klass
    self.class
  end
end