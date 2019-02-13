class Address < ApplicationRecord
  validates :name, :address, :tel, presence: true
end
