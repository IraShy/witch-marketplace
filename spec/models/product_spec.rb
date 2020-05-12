require 'rails_helper'

RSpec.describe Product, type: :model do
  let (:category) { Category.new }
  let (:user) { User.new }
  let (:order) { Order.new }

  subject { Product.new(
    name: 'Test Product',
    description: 'test description',
    image: '',
    price: 1000,
    category: category,
    user: user
  )}

  context 'validations' do

    it 'is vaild with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a price' do
      subject.price = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a price less than one cent' do
      subject.price = 0
      expect(subject).to_not be_valid
    end

    it 'is not valid when product name is less than 2 characters long' do
      subject.name = 'a'
      expect(subject).to_not be_valid
    end

    it 'is not valid when product name is more than 20 characters long' do
      subject.name = 'a' * 21
      expect(subject).to_not be_valid
    end

    it 'is not valid when description is more than 255 characters long' do
      subject.name = 'a' * 256
      expect(subject).to_not be_valid
    end
  end

  context 'price display' do

    it 'shows price in string format, with $ sign and two decimal places for cents' do
      expect(subject.price_display).to eql('$10.00')
    end
  end

  context 'associations' do
    it 'belongs to user' do
      relation = Product.reflect_on_association(:user) 
      expect(relation.macro).to eql(:belongs_to) 
    end

    it 'belongs to category' do
      relation = Product.reflect_on_association(:category) 
      expect(relation.macro).to eql(:belongs_to) 
    end

    it 'has one order' do
      relation = Product.reflect_on_association(:order) 
      expect(relation.macro).to eql(:has_one) 
    end

  #   it 'has one image' do
  #     relation = Product.reflect_on_association(:image) 
  #     expect(relation.macro).to eql(:has_one_attached) 
  #   end
  end

end
