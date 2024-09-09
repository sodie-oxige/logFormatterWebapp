class Schedule < ApplicationRecord
  belongs_to :game
  validates :date, presence: true
end
