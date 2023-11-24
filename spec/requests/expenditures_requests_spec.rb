require 'rails_helper'

RSpec.describe 'Expendituress', type: :request do
  context 'GET /index' do
    before :all do
      Expenditure.delete_all
      Category.delete_all
      User.delete_all

      @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
      @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
    end

    it 'returns http success' do
      sign_in @user
      get category_expenditures_path(@category)
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      sign_in @user
      get category_expenditures_path(@category)
      expect(response).to render_template(:index)
    end

    it 'renders content from the view' do
      sign_in @user
      get category_expenditures_path(@category)
      expect(response.body).to include('EXPENDITURES')
    end
  end

  context 'GET /show' do
    before :all do
      Expenditure.delete_all
      Category.delete_all
      User.delete_all

      @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
      @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
      @expenditure = Expenditure.create(name: 'Expenditure one', amount: 10, author: @user)
      @expenditure.categories << @category
    end

    it 'returns http success' do
      sign_in @user
      get category_expenditure_path(@category, @expenditure)
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      sign_in @user
      get category_expenditure_path(@category, @expenditure)
      expect(response).to render_template(:show)
    end

    it 'renders content from the view' do
      sign_in @user
      get category_expenditure_path(@category, @expenditure)
      expect(response.body).to include('DETAILS')
    end
  end

  context 'GET /new' do
    before :all do
      Expenditure.delete_all
      Category.delete_all
      User.delete_all

      @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
      @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
      @expenditure = Expenditure.create(name: 'Expenditure one', amount: 10, author: @user)
      @expenditure.categories << @category
    end

    it 'returns http success' do
      sign_in @user
      get new_category_expenditure_path(@category)
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      sign_in @user
      get new_category_expenditure_path(@category)
      expect(response).to render_template(:new)
    end

    it 'renders content from the view' do
      sign_in @user
      get new_category_expenditure_path(@category)
      expect(response.body).to include('EXPENDITURE')
    end
  end
end
