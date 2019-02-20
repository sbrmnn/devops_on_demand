class WebhooksController < ApplicationController
  protect_from_forgery :except => :create

  def create
    begin
      FreelancerPaymentProcessor.confirm_webhook_signature(request)
    rescue JSON::ParserError => e
      Rails.logger.error e
      head :ok and return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error e
      head :ok and return
    end
    event_json = JSON.parse(request.body.read)
    render json: event_json, status: 200
  end

  private

  def assign_fields_needed_to_freelancer(json)
    json_resp = RecursiveOpenStruct.new(json)
    fields_needed = json_resp.try(:data).try(:object).try(:verification).try(:fields_needed)
    freelancer = Freelancer.where(merchant_id: json_resp.data.object.id)
    FreelancerPaymentProcessor.new(freelancer).payout_identity_missing_fields(fields_needed) if fields_needed.present?
  end
end




