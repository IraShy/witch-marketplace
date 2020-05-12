require 'rails_helper'

RSpec.describe User, type: :model do
  let (:product) { Product.new }
  let(:order) { Order.new }

  subject { User.new(
    name: 'Test User',
    email: 'email@mail.com',
    password: 'password'
  )}

  context 'validations' do

    it 'is vaild with valid attributes' do
      expect(subject).to be_valid
    end

    # it 'must have a unique name' do
    #   
    #   expect(subject).to_not be_valid
    # end
  end

  context 'associations' do
    it 'has many products' do
      relation = User.reflect_on_association(:products) 
      expect(relation.macro).to eql(:has_many) 
    end

    it 'has many orders' do
      relation = User.reflect_on_association(:orders) 
      expect(relation.macro).to eql(:has_many) 
    end
  end
end
