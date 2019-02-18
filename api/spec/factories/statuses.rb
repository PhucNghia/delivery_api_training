FactoryBot.define do
  factory :status do
    sequence(:text) {|n| "status#{n}"}
  end
end
