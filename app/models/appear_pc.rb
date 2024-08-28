class AppearPc < ApplicationRecord
  belongs_to :log
  validates :log_id, presence: true
  validates :pc, presence: true
end
