class Certification < ApplicationRecord
  has_many :freelancers, through: :freelancer_certifications
  has_one :certification_name
end
