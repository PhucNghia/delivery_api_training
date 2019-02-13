FactoryBot.define do
  factory :user do
    sequence(:username) {|n| "username#{n}"}
    password { "password" }
    password_confirmation { "password" }
  end
end
