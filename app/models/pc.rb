class Pc < ApplicationRecord
  validates :name, presence: true
  validates :pl, presence: true
end
