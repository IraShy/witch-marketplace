require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new(
    name: 'test category'
  )}

  context 'validations' do

    it 'is vaild with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid when category name is less than 2 characters long' do
      subject.name = 'a'
      expect(subject).to_not be_valid
    end

    it 'is not valid when category name is more than 20 characters long' do
      subject.name = 'a' * 21
      expect(subject).to_not be_valid
    end
  end

 context 'associations' do
    it 'has many products' do
      relation = Category.reflect_on_association(:products) 
      expect(relation.macro).to eql(:has_many) 
    end
  end

end
