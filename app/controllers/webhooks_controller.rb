class WebhooksController < ApplicationController
  protect_from_forgery :except => :create

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    begin
     Stripe::Webhook.construct_event(
          payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      render status: 400 and return
    rescue Stripe::SignatureVerificationError => e
      render status: 400 and return
    end
    event_json = JSON.parse(request.body.read)
    render json: event_json, status: 200
  end
end


