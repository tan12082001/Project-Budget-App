require 'rails_helper'

RSpec.describe Category, type: :model do
  before :all do
    Expenditure.delete_all
    Category.delete_all
    User.delete_all

    @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
    @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
    @expenditure = Expenditure.create(name: 'Expenditure one', amount: 10, author: @user)
    @expenditure.categories << @category
  end

  context '#create valid instance' do
    it 'Category' do
      expect(@category).to be_valid
    end

    it 'not valid if no user association' do
      category = Category.create(name: 'Category one', icon: 'default-image.jpg')
      expect(category).not_to be_valid
    end
  end

  context 'Attribute validations' do
    it 'name should be present' do
      category = Category.create(user: @user, icon: 'default-image.jpg')
      expect(category).not_to be_valid
    end

    it 'Category icon should be present' do
      category = Category.create(user: @user, name: 'Default name')
      expect(category).not_to be_valid
    end

    it 'Name should be below 100 chars' do
      category = Category.create(id: 1, user: @user, name: 'A' * 102, icon: 'default-image.jpg')
      expect(category).not_to be_valid
    end
  end
end
