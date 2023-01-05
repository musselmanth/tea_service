require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should have_many(:subscription_teas) }
    it { should have_many(:teas).through(:subscription_teas)}
    it { should belong_to(:customer) }
  end

  describe 'enums' do
    it 'uses a status enum' do
      subscription = create(:subscription, status: 1)

      expect(subscription.status).to eq("active")
      expect(subscription.active?).to be(true)
      expect(subscription.cancelled?).to be(false)

      subscription.cancelled!
      expect(subscription.status).to eq("cancelled")
      expect(subscription.cancelled?).to be(true)
      expect(subscription.active?).to be(false)
    end

    it 'uses a frequency enum' do
      subscription = create(:subscription, status: 1)
    end
  end
end
