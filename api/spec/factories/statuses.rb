FactoryBot.define do
  factory :status do
    text { ["not received", "received", "received product", "is delivering", "delivered", "Can not be delivered"].sample }
  end
end
