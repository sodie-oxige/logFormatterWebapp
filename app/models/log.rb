class Log < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true
  validates :gm, presence: true
end
