class Api::V1::SubscriptionsController < ApplicationController

  def index
    subscriptions = Customer.find(params[:customer_id]).subscriptions
    render_json(SubscriptionSerializer.new(subscriptions))
  end

  def create
    new_sub = Subscription.new(subscription_params)
    if new_sub.save
      render_json(SubscriptionSerializer.new(new_sub), :created)
    else
      render_json(ErrorSerializer.new(new_sub.errors.full_messages), :bad_request)
    end
  end

  private

  def subscription_params
    sub_params = params.permit(:customer_id, :title, :price, :frequency, teas: [:quantity, :tea_id])
    sub_params[:subscription_teas_attributes] = sub_params.delete :teas
    sub_params
  end

end