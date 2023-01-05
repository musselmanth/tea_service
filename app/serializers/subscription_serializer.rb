class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title,
             :price,
             :frequency,
             :status

  attribute :teas do |sub|
    sub.subscription_teas.map do |sub_tea|
      {tea_id: sub_tea.tea_id.to_s, quantity: sub_tea.quantity}
    end
  end

end