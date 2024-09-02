class Character < ApplicationRecord
  belongs_to :pl
  has_many :appear_pcs
  has_many :log, through: :appear_pcs
  has_many :nicknames
  accepts_nested_attributes_for :nicknames, allow_destroy: true
  validates :name, presence: true, uniqueness: true
  has_many_attached :images
end
