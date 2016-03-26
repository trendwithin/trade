# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(email: 'admin@seedfile.com', password: 'password', role: 'admin', confirmed_at: "<%= Time.now %>")

12.times do
  title = Faker::Beer.name
  body = Faker::Hipster.paragraph(2)
  user_id = admin.id
  Blog.create!(title: title, body: body, user_id: user_id, published: 1)
end
