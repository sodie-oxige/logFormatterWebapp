class User < ApplicationRecord
  has_many :characters, foreign_key: "pl_id"
  has_many :logs
  validates :name, presence: true, uniqueness: true
  validates :userid, format: { with: /\A[\w_]+\z/ }
  validates :password, format: { with: /\A[!-~]{8,}\z/ }
  has_secure_password
end
