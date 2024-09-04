class Schedule < ApplicationRecord
  belongs_to :session
  validates :date, presence: true
end
