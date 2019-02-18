FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    password { "password" }
    password_confirmation { "password" }
    callback_link { "http://webhook.site/be41f6b8-a33c-47e9-aceb-db946c5384a1" }

    factory :user_with_orders do
      transient do
        orders_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:order, evaluator.orders_count, user_id: user.id)
      end
    end
  end

  factory :user_no_callback_link, parent: :user_with_orders do
    callback_link { }
  end
end
