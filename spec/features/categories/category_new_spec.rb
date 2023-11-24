require 'rails_helper'

RSpec.describe 'Category', type: :system do
    before :all do
        Expenditure.delete_all
        Category.delete_all
        User.delete_all

        @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
        @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
        @expenditure = Expenditure.create(name: 'Expenditure one', amount: 10, author: @user)
        @expenditure.categories << @category
    end

    context '#new view' do
      it 'should create a new category' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        click_link 'Add new Category'
        sleep(1)
        fill_in 'Name', with: 'Category three'
        fill_in 'Icon', with: @category.icon
        click_button 'Save'
        sleep(1)
        expect(current_path).to eq(categories_path)
        expect(page).to have_content('Category three')
        expect(page).to have_content('$ 0.0')
        expect(page).to have_css('img.category-img')
      end

      it 'back action should take to categories view' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        click_link 'Add new Category'
        sleep(1)
        find('.back-icon').click
        sleep(1)
        expect(current_path).to eq(categories_path)
      end
    end
end