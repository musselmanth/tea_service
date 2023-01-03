FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { "Sample Tea Description" }
    temperature { 193.0 }
    brewtime { 180 }
  end
end
