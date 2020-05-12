require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:user) { User.new }
  let (:product) { Product.new }

  subject { Order.new(
    user: user,
    product: product
  )}

  context 'validations' do

    it 'is vaild with valid attributes' do
      expect(subject).to be_valid
    end
  end

  context 'associations' do
    it 'belongs to user' do
      relation = Order.reflect_on_association(:user) 
      expect(relation.macro).to eql(:belongs_to) 
    end

    it 'belongs to product' do
      relation = Order.reflect_on_association(:product) 
      expect(relation.macro).to eql(:belongs_to) 
    end
  end
end
