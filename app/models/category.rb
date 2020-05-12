class Category < ApplicationRecord
  validates :name, presence: true, length: { in: 2..20 }
  has_many :products
end
