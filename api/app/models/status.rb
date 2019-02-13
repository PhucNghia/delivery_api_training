class Status < ApplicationRecord
  has_many :orders

  validates :text, presence: true, uniqueness: true
end
