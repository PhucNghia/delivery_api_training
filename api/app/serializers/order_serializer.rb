class OrderSerializer < ActiveModel::Serializer
  attributes :id, :amount, :user_id

  has_many :products
  belongs_to :bill_address
  belongs_to :ship_address
  belongs_to :status
end
