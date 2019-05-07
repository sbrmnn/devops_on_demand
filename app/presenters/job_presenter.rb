class JobPresenter < ApplicationPresenter

  def poster
    "#{model.user.first_name} #{model.user.last_name}"
  end


  def poster_email
    UserPresenter.new(model.user).relay_user_name
  end

  def acceptance
    model.acceptance
  end

  def canceled
    model.canceled
  end

  def from
    model.from
  end

  def to
    model.to
  end

  def hours
    model.hours
  end

  def total
    '%.2f' % (model.total/100.0)
  end

  def description
    model.description
  end

  def id
    model.id
  end


  def freelancer
    model.freelancer
  end



end