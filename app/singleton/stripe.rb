class Stripe
  include Singleton

  def self.stripe_countries
    @@stripe_countries
  end

  def initialize
  end

  @@stripe_countries = {
      "US"=>"United States",
      "AU"=>"Australia",
      "AT"=>"Austria",
      "BE"=>"Belgium",
      "BR"=>"Brazil ",
      "CA"=>"Canada",
      "DK"=>"Denmark",
      "FI"=>"Finland",
      "FR"=>"France",
      "DE"=>"Germany",
      "HK"=>"Hong Kong",
      "IE"=>"Ireland",
      "JP"=>"Japan",
      "LU"=>"Luxembourg",
      "MX"=>"Mexico",
      "NL"=>"Netherlands",
      "NZ"=>"New Zealand",
      "NO"=>"Norway",
      "SG"=>"Singapore",
      "ES"=>"Spain",
      "SE"=>"Sweden",
      "CH"=>"Switzerland",
      "GB"=>"United Kingdom",
      "IT"=>"Italy",
      "PT"=>"Portugal"
  }
end