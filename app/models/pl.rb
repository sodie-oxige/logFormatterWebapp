class Pl < ApplicationRecord
  has_many :pcs
  has_many :logs
  validates :name, presence: true, uniqueness: true
end
