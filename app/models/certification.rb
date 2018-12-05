class Certification < ApplicationRecord
  belongs_to :freelancers
  has_one :certification_name
end
