class Product < ApplicationRecord
  validates :name, presence: true, length: { in: 2..20 }
  validates :description, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  belongs_to :user
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
  has_one_attached :image

  def price_display
    '$' + sprintf('%.2f', (self.price / 100.0))
  end

  def short_description
    if self.description.length > 70
      self.description[0..69] + '...'
    else
      self.description
    end
  end
end
