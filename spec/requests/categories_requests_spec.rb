require 'rails_helper'

RSpec.describe 'Categories', type: :request do
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
            get categories_path
            expect(response).to have_http_status(:success)
        end

        it 'renders index view' do
            sign_in @user
            get categories_path
            expect(response).to render_template(:index)
        end

        it 'renders content from the view' do
            sign_in @user
            get categories_path
            expect(response.body).to include('BudgetMap')
        end
    end
end
