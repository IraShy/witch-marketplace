# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# Order.destroy_all
# Category.destroy_all
# Product.destroy_all
# User.destroy_all

# Create users
user_1 = User.create(name: 'user_1', email: 'user1@mail.com', password: 'password')
buyer = User.create(name: 'buyer', email: 'buyer@mail.com', password: 'password')
# user_3 = User.create(name: 'admin', email: 'admin@mail.com', password: 'password', admin: true)

# Create topics

for i in (1..7) do
  Category.create(name: "category#{i}")
end


for i in (1..15) do
  num = rand(1..7)
    Product.create(
      name: "product_#{i}",
      description: "interesting description No #{i}",
      price: 100 * num,
      user: user_1,
      category_id: num
    )
end
# Create votes on topics 1-4 by user_1
# for i in (1..4) do
#     Vote.create(
#       topic_id: i,
#       user_id: 1
#     )
# end

# # Create a vote on topic 3 by user_2
# Vote.create(
#   topic_id: 3,
#   user_id: 2
# )