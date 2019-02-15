FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "username#{n}"}
    password { "password" }
    password_confirmation { "password" }

    factory :user_with_orders do
      transient do
        orders_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:order, evaluator.orders_count, user_id: user.id)
      end
    end
  end
end
