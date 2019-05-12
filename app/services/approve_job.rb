class ApproveJob
  include Callable

  def initialize(job)
    @job = job
  end

  def call
    return if @job.canceled.present?
    @job.lock!.update_attributes(acceptance: true)
    charge_credit_card(@job)
    @job.reload
  end

  private

  def charge_credit_card(job)
    credit_card = job.credit_cards.last
    if credit_card.present?
      tr = Transaction.create(credit_card: credit_card, job: job,  amount: job.total, freelancer: job.freelancer, user: job.user)
      if tr.persisted?
        charge = CustomerPaymentProcessor.new(job.user).charge_source(job.total, "Job ##{job.id}")
        tr.update_attributes(merchant_id: charge.id, amount_refunded: charge.amount_refunded )
      end
    end
  end
end

