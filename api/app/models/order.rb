class Order < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :status
  belongs_to :bill_address, foreign_key: :bill_address_id, class_name: "Address",
    dependent: :destroy, optional: true
  belongs_to :ship_address, foreign_key: :ship_address_id, class_name: "Address",
    dependent: :destroy, optional: true
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  validates :amount, presence: true
end
