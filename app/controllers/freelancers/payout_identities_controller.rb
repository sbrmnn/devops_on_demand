class Freelancers::PayoutIdentitiesController < ApplicationController
  before_action :authenticate_user!
  include StrongParameterizable

  def create
    current_user.freelancer.build_payout_identity(payout_identities_params)
  end

  def payout_identities_params
    whitelist_params(params, :payout_identity)
  end
end
