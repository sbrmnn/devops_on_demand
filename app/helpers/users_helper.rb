module UsersHelper
  def display_bank_account(bank_account)
    if bank_account.present?
      "**********#{bank_account}"
    end
  end

  def date_string(day, month, year)
    if day.present? && month.present? && year.present?
      "#{day}/#{month}/#{year}"
    else
      nil
    end
  end

  def sepa_countries
    SepaCountries.instance.list
  end
end
