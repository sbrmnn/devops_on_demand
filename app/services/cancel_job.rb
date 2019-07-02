class CancelJob
  include Callable

  def initialize(job)
    @job = job
  end

  def call
    @job.with_lock do
      @job.update_attributes(canceled: true)
      refund_credit_card(@job)
    end
    @job.reload
  end


  private

  def refund_credit_card(job)
    if job.transactions.present?
      latest_transaction = job.transactions.last
      if latest_transaction.amount_refunded == 0
       refund = CustomerPaymentProcessor.new(job.user).refund_source(tr.merchant_id)
       Transaction.create(credit_card: latest_transaction.credit_card, job: job,  amount: latest_transaction.amount ,amount_refunded: refund.amount, product: job.product, user: job.user)
      end
    end
  end
end