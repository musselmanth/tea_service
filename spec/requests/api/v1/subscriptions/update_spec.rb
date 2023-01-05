require 'rails_helper'

RSpec.describe 'update subscription' do
  describe 'cancel subscription' do
    let!(:teas) { create_list(:tea, 2) }
    let!(:customer) { create(:customer) }
    let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

    describe 'happy path' do
      let!(:http_body) { { 
        status: "cancelled"
      } }

      it 'cancels a subscription' do
        subscription = create(:subscription, customer: customer)
        create(:subscription_tea, subscription: subscription, tea: teas[0])

        expect(subscription.status).to eq("active")

        patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", headers: headers, params: http_body.to_json

        expect(subscription.reload.status).to eq("cancelled")
      end
    end
  end
end