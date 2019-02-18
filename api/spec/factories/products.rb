FactoryBot.define do
  factory :product do
    name { FFaker::Food.vegetable }
    weight { rand(20..1000) }
    quantity { rand(1..10) }
    order
  end
end
