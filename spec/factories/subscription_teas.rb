FactoryBot.define do
  factory :subscription_tea do
    tea
    subscription
    quantity { rand(1..10) }
  end
end
