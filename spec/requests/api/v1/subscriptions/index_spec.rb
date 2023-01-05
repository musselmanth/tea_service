require 'rails_helper'

RSpec.describe 'subscriptions#index' do

  it 'gets all customer subscriptions' do
    customer = create(:customer)
    teas = create_list(:tea, 3)
    subscription_1 = create(:subscription, customer: customer, status: :active)
    subscription_2 = create(:subscription, customer: customer, status: :active)
    subscription_3 = create(:subscription, customer: customer, status: :cancelled)

    create(:subscription_tea, tea: teas[0], subscription: subscription_1, quantity: 1)
    create(:subscription_tea, tea: teas[1], subscription: subscription_1, quantity: 2)
    create(:subscription_tea, tea: teas[2], subscription: subscription_2, quantity: 5)
    create(:subscription_tea, tea: teas[0], subscription: subscription_3, quantity: 1)
    create(:subscription_tea, tea: teas[1], subscription: subscription_3, quantity: 1)
    create(:subscription_tea, tea: teas[2], subscription: subscription_3, quantity: 1)

    get "/api/v1/customers/#{customer.id}/subscriptions"
    
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    expect(response_body).to have_key(:data)
    expect(response_body[:data]).to be_an(Array)

    subs = response_body[:data]

    subs.each do |sub|
      expect(sub).to be_a Hash
      expect(sub[:id]).to be_a(String)
      expect(sub[:type]).to eq("subscription")
      expect(sub[:attributes]).to be_a(Hash)

      sub_atts = sub[:attributes]
      expect(sub_atts[:title]).to be_a String
      expect(sub_atts[:price]).to be_an Integer
      expect(sub_atts[:status]).to be_a String
      expect(sub_atts[:frequency]).to be_an Integer
      expect(sub_atts[:teas]).to be_an(Array)
      sub_atts[:teas].each do |tea|
        expect(tea[:tea_id]).to be_a(String)
        expect(tea[:quantity]).to be_an(Integer)
      end
    end

    expect(subs[0][:attributes][:status]).to eq("active")
    expect(subs[2][:attributes][:status]).to eq("cancelled")
  end

  it 'has correct details about a subscription' do
    customer = create(:customer)
    teas = create_list(:tea, 2)
    subscription_1 = create(:subscription, customer: customer, status: :active)
    create(:subscription_tea, tea: teas[0], subscription: subscription_1, quantity: 1)
    create(:subscription_tea, tea: teas[1], subscription: subscription_1, quantity: 2)

    get "/api/v1/customers/#{customer.id}/subscriptions"
    
    expect(response).to be_successful

    subs = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(subs.length).to eq(1)

    sub = subs.first

    expect(sub[:id]).to eq(subscription_1.id.to_s)
    expect(sub[:type]).to eq("subscription")
    expect(sub[:attributes][:title]).to eq(subscription_1.title)
    expect(sub[:attributes][:price]).to eq(subscription_1.price)
    expect(sub[:attributes][:status]).to eq(subscription_1.status)
    expect(sub[:attributes][:frequency]).to eq(subscription_1.frequency)
    expect(sub[:attributes][:teas][0][:tea_id]).to eq(teas[0].id.to_s)
    expect(sub[:attributes][:teas][0][:quantity]).to eq(subscription_1.subscription_teas[0].quantity)
    expect(sub[:attributes][:teas][1][:tea_id]).to eq(teas[1].id.to_s)
    expect(sub[:attributes][:teas][1][:quantity]).to eq(subscription_1.subscription_teas[1].quantity)
  end

  describe 'sad path' do
    it 'returns a not found error if the customer id is incorrect' do
      get "/api/v1/customers/1/subscriptions"
    
      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      response_body = JSON.parse(response.body, symbolize_names: true)
      expected = {message: "your query could not be completed", errors: ["Couldn't find Customer with 'id'=1"]}
      expect(response_body).to eq(expected)
    end

    it 'returns empty array with no subscriptions' do
      customer = create(:customer)
      get "/api/v1/customers/#{customer.id}/subscriptions"

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      
      expected = {
        data: []
      }

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to eq(expected)

    end
  end
  
end