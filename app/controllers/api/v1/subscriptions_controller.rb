class Api::V1::SubscriptionsController < ApplicationController

  def index
    subscriptions = Customer.find(params[:customer_id]).subscriptions
    render_json(SubscriptionSerializer.new(subscriptions))
  end

end