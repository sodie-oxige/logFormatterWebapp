class User < ApplicationRecord
  has_many :characters, foreign_key: "pl_id"
  has_many :logs, foreign_key: "gm_id"
  validates :userid, presence: true, uniqueness: true
  validates :userid, format: { with: /\A[\w_]+\z/ }
  validates :password, format: { with: /\A[!-~]+\z/ }
  has_secure_password

  scope :filtered_all, -> { where.not(name: "guest") }
end
