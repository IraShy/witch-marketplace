class Category < ApplicationRecord
  # used to have 20 chars max for the name, but changed later
  validates :name, presence: true, length: { in: 2..30 }
  has_many :products
end
