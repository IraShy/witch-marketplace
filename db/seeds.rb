require_relative "data/products"
require_relative "data/categories"

Category.destroy_all
User.destroy_all
Product.destroy_all
Order.destroy_all

# Create users
user_1 = User.create(name: 'Cassandra', email: 'cassandra@mail.com', password: 'password')
buyer = User.create(name: 'Veda', email: 'veda@mail.com', password: 'password')
user_3 = User.create(name: 'admin', email: 'admin@mail.com', password: 'password', admin: true)

# Create categories

categories.each do |category|
  category = Category.create(category)
end 

# Create products

products.each do |product|
  product = Product.create(product)
end 
