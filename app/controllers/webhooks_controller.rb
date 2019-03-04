class WebhooksController < ApplicationController
  protect_from_forgery :except => :create

  def create
    begin
      FreelancerPaymentProcessor.adapter.confirm_webhook_signature(request)
    rescue JSON::ParserError => e
      Rails.logger.error e
      head :ok and return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error e
      head :ok and return
    end
    request_body = request.body.read
    event_json = JSON.parse(request_body)
    Rails.logger.info request_body
    assign_fields_needed_to_freelancer(event_json)
    render json: event_json, status: 200
  end

  private

  def assign_fields_needed_to_freelancer(json)
    json_resp = RecursiveOpenStruct.new(json)
    return unless json_resp.type == 'account.updated'
    fields_needed = json_resp.try(:data).try(:object).try(:verification).try(:fields_needed)
    freelancer = Freelancer.find_by(merchant_id: json_resp.account)
    FreelancerPaymentProcessor.new(freelancer).payout_identity_missing_fields(fields_needed) if freelancer.present?
  end
end




