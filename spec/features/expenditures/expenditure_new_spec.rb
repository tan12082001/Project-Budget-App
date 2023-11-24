require 'rails_helper'

RSpec.describe 'Expenditure', type: :system do
  before :all do
    Expenditure.delete_all
    Category.delete_all
    User.delete_all

    @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
    @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
    @category2 = Category.create(id: 2, user: @user, name: 'Category two', icon: 'default-image.jpg')
    @expenditure = Expenditure.create(name: 'Expenditure one', amount: 10, author: @user)
    @expenditure.categories << @category
  end

  context '#new view' do
    it 'should render new expenditure view' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit new_category_expenditure_path(@category)
      sleep(1)
      expect(page).to have_content('EXPENDITURE')
    end

    it 'back action should take to categories view' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit new_category_expenditure_path(@category)
      sleep(1)
      find('.back-icon').click
      sleep(1)
      expect(current_path).to eq(category_expenditures_path(@category))
    end
  end

  context '#new action' do
    it 'new action should create new expenditure' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit category_expenditures_path(@category)
      sleep(1)
      click_link 'Add new Expenditure'
      sleep(1)
      fill_in 'Name', with: 'Expenditure three'
      fill_in 'Amount $', with: 20
      check 'Category two'
      click_button 'Save'
      sleep(1)
      expect(current_path).to eq(category_expenditures_path(@category))
      expect(page).to have_content('Expenditure three')
      expect(page).to have_content('$ 20.0')
      expect(page).to have_css('img.category-img')
    end
  end
end
