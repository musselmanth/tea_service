# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer = FactoryBot.create(:customer)
teas = FactoryBot.create_list(:tea, 30)

subscription_1 = FactoryBot.create(:subscription, customer: customer)
subscription_2 = FactoryBot.create(:subscription, customer: customer, status: :cancelled)

FactoryBot.create(:subscription_tea, subscription: subscription_1, tea: teas[8])
FactoryBot.create(:subscription_tea, subscription: subscription_1, tea: teas[14])
FactoryBot.create(:subscription_tea, subscription: subscription_2, tea: teas[3])
FactoryBot.create(:subscription_tea, subscription: subscription_2, tea: teas[19])
FactoryBot.create(:subscription_tea, subscription: subscription_2, tea: teas[24])