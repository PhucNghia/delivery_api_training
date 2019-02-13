FactoryBot.define do
  factory :order do
    amount { rand(1..99) * 10000 }
    bill_address
    ship_address
    status
  end
end
