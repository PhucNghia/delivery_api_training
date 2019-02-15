class Order < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :status
  belongs_to :user
  belongs_to :bill_address, foreign_key: :bill_address_id, class_name: "Address",
    dependent: :destroy
  belongs_to :ship_address, foreign_key: :ship_address_id, class_name: "Address",
    dependent: :destroy
  accepts_nested_attributes_for :products, allow_destroy: true
  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  validates :amount, presence: true
  validate :must_have_product

  def owner?(user)
    user_id == user.id
  end

  private

  def must_have_product
    if products.empty?
      errors.add(:order, "must have at least one product")
    end
  end
end
