require 'rails_helper'

RSpec.describe 'create subscription' do
  let!(:teas) { create_list(:tea, 2) }
  let!(:customer) { create(:customer) }
  let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

  describe 'happy path' do
    let!(:http_body) { {
      title: "Monthly Green Teas", 
      price: 4500,
      frequency: 4,
      teas: [
        {
          quantity: 1,
          tea_id: teas[0].id
        },
        {
          quantity: 4,
          tea_id: teas[1].id
        }
      ]

    } }

    it 'creates a new subscription for the customer' do    
      expect(customer.subscriptions.empty?).to be(true)
      
      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: http_body.to_json

      expect(customer.subscriptions.length).to eq(1)

      new_sub = customer.subscriptions.first

      expect(new_sub.title).to eq(http_body[:title])
      expect(new_sub.price).to eq(http_body[:price])
      expect(new_sub.frequency).to eq(http_body[:frequency])
      expect(new_sub.teas).to match_array(teas)
      expect(new_sub.subscription_teas[0].quantity).to eq(http_body[:teas][0][:quantity])    
      expect(new_sub.subscription_teas[1].quantity).to eq(http_body[:teas][1][:quantity])
    end

    it 'returns the subscription upon create' do
      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: http_body.to_json
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(201)
      new_sub = customer.subscriptions.first
      
      expected = {
        data: {
          id: new_sub.id.to_s,
          type: "subscription",
          attributes: {
            title: new_sub.title,
            price: new_sub.price,
            frequency: new_sub.frequency,
            status: "active",
            teas: [
              {
                tea_id: new_sub.subscription_teas[0].tea_id.to_s,
                quantity: new_sub.subscription_teas[0].quantity
              },
              {
                tea_id: new_sub.subscription_teas[1].tea_id.to_s,
                quantity: new_sub.subscription_teas[1].quantity
              }
            ]
          }
        }
      }

      expect(response_body).to eq(expected)
    end
  end

  describe 'sad path' do
    let!(:http_body) { {
      title: "Monthly Green Teas", 
      price: 4500,
      frequency: "monthly",
      teas: [
        {
          quantity: 1,
          tea_id: teas[0].id
        },
        {
          quantity: 4,
          tea_id: teas[1].id
        }
      ]

    } }

    it 'returns validation errors' do
      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: http_body.to_json
      response_body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      
      expected = {
        message: "your request could not be completed",
        errors: [
          "Frequency is not a number"
        ]
      }

      new_sub = customer.subscriptions.first

      expect(response_body).to eq(expected)
    end
  end
end