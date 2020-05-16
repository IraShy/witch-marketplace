class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
end

def price_display(price)
  '$' + sprintf('%.2f', (price / 100.0))
end
