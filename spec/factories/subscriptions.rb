FactoryBot.define do
  factory :subscription do
    tea { nil }
    customer { nil }
    title { "MyString" }
    price { 1 }
    status { 1 }
    frequency { 1 }
  end
end
