class Log < ApplicationRecord
  belongs_to :gm, class_name: "User"
  has_many :log_contents
  has_many :appear_pcs
  has_many :pcs, through: :appear_pcs, source: :character
  validates :name, presence: true
  validates :date, presence: true
  validates :gm, presence: true
end
