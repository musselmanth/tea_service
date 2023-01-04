FactoryBot.define do
  factory :subscription do
    customer
    title { Faker::Tea.variety }
    price { Faker::Number.between(from: 100, to: 10000) }
    status { 1 }
    frequency { 0 }
  end
end
