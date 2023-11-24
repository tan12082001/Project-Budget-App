require 'rails_helper'

RSpec.describe Expenditure, type: :model do
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
        it 'Expenditure' do
            expect(@expenditure).to be_valid
        end

        it 'not valid if no user association' do
            expenditure = Expenditure.create(name: 'Expenditure two', amount: 10)
            expect(expenditure).not_to be_valid
        end
    end

    context 'Attribute validations' do
        it 'name should be present' do
            expenditure = Expenditure.create(amount: 10, author: @user)
            expect(expenditure).not_to be_valid
        end

        it 'amount should be present' do
            expenditure = Expenditure.create(name: 'Expenditure two', author: @user)
            expect(expenditure).not_to be_valid
        end

        it 'Name should be below 100 chars' do
            expenditure = Expenditure.create(name: 'Expenditure two'*10, amount: 10, author: @user)
            expect(expenditure).not_to be_valid
        end

        it 'Amount should be a positive number' do
            expenditure = Expenditure.create(name: 'Expenditure two', amount: -10, author: @user)
            expect(expenditure).not_to be_valid
        end
    end
end