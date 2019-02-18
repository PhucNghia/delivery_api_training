FactoryBot.define do
  factory :order do
    amount { rand(1..99) * 10000 }
    bill_address
    ship_address
    status
    user

    transient do
      products_count { 1 }
    end

    before(:create) do |order, evaluator|
      order.products = build_list :product, evaluator.products_count
    end
  end
end
