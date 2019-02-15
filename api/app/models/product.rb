class Product < ApplicationRecord
  before_destroy :can_destroyed?
  belongs_to :order

  validates :name, :weight, :quantity, presence: true

  private

  def can_destroyed?
    return true if order.products.size > 1
    errors.add(:order, "must have at least one product")
    throw(:abort)
  end
end
