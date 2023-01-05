FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.sentence(word_count: 8) }
    temperature { 193 }
    brewtime { 180 }
  end
end

