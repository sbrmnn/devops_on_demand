class Users::CreditCardsController < ApplicationController

  before_action :authenticate_user!
  include StrongParameterizable



  def create
    @user = current_user
    @credit_card = current_user.build_credit_card(credit_card_params)
    @credit_card.save
  end

  def update
    @user = current_user
    @credit_card = current_user.credit_card
    @credit_card.update_attributes(credit_card_params)
  end

  private

  def credit_card_params
    whitelist_params(params, :credit_card)
  end
end
