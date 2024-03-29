class Freelancers::PayoutIdentitiesController < ApplicationController
  before_action :authenticate_user!

  def update
    current_user.freelancer.payout_identity.update_attributes(payout_identities_params)
  end

  def create
    current_user.freelancer.build_payout_identity(payout_identities_params).save
  end

  def payout_identities_params
    whitelist_params(params, :payout_identity)
  end
end
