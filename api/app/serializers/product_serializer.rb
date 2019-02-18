class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :weight, :quantity, :order_id
end
