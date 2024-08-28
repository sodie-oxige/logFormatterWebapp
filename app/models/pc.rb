class Pc < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :pl, presence: true
end
