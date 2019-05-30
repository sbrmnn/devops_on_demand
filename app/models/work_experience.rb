class WorkExperience < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :employer
end
