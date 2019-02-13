class Product < ApplicationRecord
  belongs_to :order

  validates :name, :weight, :quantity, presence: true
end
