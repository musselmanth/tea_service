require 'rails_helper'

RSpec.describe 'subscriptions#index' do

  it 'gets all customer subscriptions' do
    customer = create(:customer)
    teas = create_list(:tea, 3)
    subscription_1 = create(:subscription, customer: customer, status: :active)
    subscription_2 = create(:subscription, customer: customer, status: :active)
    subscription_3 = create(:subscription, customer: customer, status: :cancelled)

    subscription_1.teas << teas[0..1]
    subscription_2.teas << teas[2]
    subscription_3.teas << teas

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
      expect(sub_atts[:status]).to be_an Integer
      expect(sub_atts[:freqency]).to be_an Integer
    end

    expect(subs[0][:attributes][:status]).to eq(1)
    expect(subs[2][:attributes][:status]).to eq(0)
  end
  
end