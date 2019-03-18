class Users::CreditCardsController < ApplicationController

  before_action :authenticate_user!
  before_action :user
  layout 'profile'

  def show

  end

  def create
    @credit_card = user.build_credit_card(credit_card_params)
    @credit_card.save
  end

  def update
    @credit_card = user.credit_card
    @credit_card.update_attributes(credit_card_params)
  end

  private

  def credit_card_params
    whitelist_params(params, :credit_card)
  end
end
