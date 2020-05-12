class Product < ApplicationRecord
  validates :name, presence: true, length: { in: 2..20 }
  validates :description, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  belongs_to :user
  belongs_to :category
  has_one    :order
  # has_one_attached :image

  def price_display
    '$' + sprintf('%.2f', (self.price / 100.0))
  end
end
