class Pl < ApplicationRecord
  has_many :characters
  has_many :logs
  validates :name, presence: true, uniqueness: true
end
