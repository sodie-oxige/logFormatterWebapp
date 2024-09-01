class Pc < ApplicationRecord
  belongs_to :pl
  has_many :appear_pcs
  has_many :log, through: :appear_pcs
  validates :name, presence: true, uniqueness: true
  has_many_attached :images
end
