class WorkExperience < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :employer
  validates_format_of :from, with: /((02\/[0-2]\d)|((01|[0][3-9]|[1][0-2])\/(31|30|[0-2]\d)))\/[12]\d{3}/

  validates_format_of :to,   with: /((02\/[0-2]\d)|((01|[0][3-9]|[1][0-2])\/(31|30|[0-2]\d)))\/[12]\d{3}/, allow_blank: true
end
