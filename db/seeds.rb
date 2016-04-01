# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
time = Faker::Date.backward(1)
times2 = Faker::Date.backward(2)
times3 = Faker::Date.backward(3)
times4 = Faker::Date.backward(4)

admin = User.create!(email: 'admin@seedfile.com', password: 'password', role: 'admin', confirmed_at: time)

12.times do
  title = Faker::Beer.name
  body = Faker::Hipster.paragraph(2)
  user_id = admin.id
  Blog.create!(title: title, body: body, user_id: user_id, published: 1)
end

TradeLog.create!(user_id: admin.id, trade_opened_at: times4, symbol: 'XYZ', position_size: 100, entry_price: 10, stop: 9, exit_one_on: time, exit_one_shares: 100, exit_one_price: 15)
TradeLog.create!(user_id: admin.id, trade_opened_at: times4, symbol: 'ABC', position_size: 100, entry_price: 10, stop: 9, exit_one_on: times3, exit_one_shares: 25, exit_one_price: 11, exit_two_on: times2, exit_two_shares: 25, exit_two_price: 12, exit_three_on: time, exit_three_shares: 25, exit_three_price: 15)

# chirps

10.times do
  content = Faker::Hipster.paragraph(1)
  admin.chirps.create!(content: content)
end
