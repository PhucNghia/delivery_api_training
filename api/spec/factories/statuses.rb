FactoryBot.define do
  factory :status do
    sequence(:text) {|n| "status#{n}"}
  end
end
#["not received", "received", "received product", "is delivering", "delivered", "Can not be delivered"]
