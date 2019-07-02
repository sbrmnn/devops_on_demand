class UserPresenter < ApplicationPresenter

  def product
    model.product.present? ? model.product : model.build_product
  end

  def setting
    model.setting
  end

  def transactions
    model.transactions
  end

  def email
    model.email
  end

  def id
    model.id
  end

  def relay_user_name
    model.relay_user_name
  end

  def full_name
    "#{model.first_name} #{model.last_name}"
  end

  def credit_card
    model.credit_card.present? ? model.credit_card :  model.build_credit_card
  end
end



