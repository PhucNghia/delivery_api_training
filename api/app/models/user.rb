class User < ApplicationRecord
  has_secure_password
  has_many :orders, dependent: :destroy

  validates :password, presence: true, on: :create
  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
