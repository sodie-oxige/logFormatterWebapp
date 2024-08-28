class Log < ApplicationRecord
  has_many :appear_pcs
  validates :name, presence: true
  validates :date, presence: true
  validates :gm, presence: true
  accepts_nested_attributes_for :appear_pcs
end
