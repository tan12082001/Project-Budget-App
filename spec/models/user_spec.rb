require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    Expenditure.delete_all
    Category.delete_all
    User.delete_all

    @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
  end

  context '#create instance' do
    it 'User should be valid' do
      expect(@user).to be_valid
    end

    it 'name should be present' do
      @user1 = User.create(surname: 'Spec', password: 'testing')
      expect(@user1).not_to be_valid
    end

    it 'email should be present' do
      @user2 = User.create(name: 'User', surname: 'Spec', password: 'testing')
      expect(@user2).not_to be_valid
    end
  end
end
