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
        expect(response).to be_successful
        expect(response).to have_http_status(202)

        expect(subscription.reload.status).to eq("cancelled")

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to have_key(:data)
        expect(response_body[:data]).to be_a(Hash)
        expect(response_body[:data]).to have_key(:id)
        expect(response_body[:data]).to have_key(:type)
        expect(response_body[:data]).to have_key(:attributes)
      end
    end
  end
end