class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title,
             :price,
             :frequency,
             :status

  attribute :teas do |sub|
    sub.tea_summary
  end
end