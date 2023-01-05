FactoryBot.define do
  factory :subscription do
    customer
    title { Faker::Lorem.sentence(word_count: 2) }
    price { Faker::Number.between(from: 100, to: 10000) }
    status { 1 }
    frequency { [2, 4, 6].sample }
  end
end
