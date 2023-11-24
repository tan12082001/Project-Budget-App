require 'rails_helper'

RSpec.describe 'Expenditure', type: :system do
  before :all do
    Expenditure.delete_all
    Category.delete_all
    User.delete_all

    @user = User.create(id: 1, name: 'User', surname: 'one', email: 'test@gmail.com', password: '123456')
    @category = Category.create(id: 1, user: @user, name: 'Category one', icon: 'default-image.jpg')
    @expenditure = Expenditure.create(name: 'Expenditure one', amount: 10, author: @user)
    @expenditure.categories << @category
    @expenditure2 = Expenditure.create(name: 'Expenditure two', amount: 10, author: @user)
    @expenditure2.categories << @category
    @expenditure3 = Expenditure.create(name: 'Expenditure three', amount: 10, author: @user)
    @expenditure3.categories << @category
  end

  context '#all_expenditures view' do
    it 'should render all_expenditure details' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit all_expenditures_path
      sleep(1)
      expect(page).to have_content('BudgetMap')
      expect(page).to have_content('Total Budget: $30.0')
      expect(page).to have_content('Expenditure one')
      expect(page).to have_content('Expenditure two')
      expect(page).to have_content('Expenditure three')
      expect(page).to have_content("#{@expenditure.created_at.strftime('%d %b %Y')}")
      expect(page).to have_content("#{@expenditure2.created_at.strftime('%d %b %Y')}")
      expect(page).to have_content("#{@expenditure3.created_at.strftime('%d %b %Y')}")
    end
  end
end
