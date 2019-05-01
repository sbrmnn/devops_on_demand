class LegalEntityPresenter < ApplicationPresenter

  def dob
    if model.dob_year && model.dob_month && model.dob_day
      "#{model.dob_year}-#{model.dob_month}-#{model.dob_day}".try(:to_date)
    else
      nil
    end
  end
end