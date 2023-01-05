FactoryBot.define do
  factory :tea do
    title { Faker::Lorem.sentence(word_count: 2) }
    description { Faker::Lorem.sentence(word_count: 8) }
    temperature { 193 }
    brewtime { 180 }
  end
end

