class AppearPc < ApplicationRecord
  validates :log_id, presence: true
  validates :pc, presence: true
end
