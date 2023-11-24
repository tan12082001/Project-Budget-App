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
    end

    context '#show view' do
      it 'should render expenditure details' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        visit category_expenditure_path(@category, @expenditure)
        sleep(1)
        expect(page).to have_content('DETAILS')
        expect(page).to have_content('Categories included:')
        expect(page).to have_content('Category one')
        expect(page).to have_content('$10.0')
        expect(page).to have_content('Expenditure one')
        expect(page).to have_content("#{@expenditure.created_at.strftime('%d %b %Y')}")
        expect(page).to have_content('DELETE')
      end

      it 'back action should take to categories view' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        visit category_expenditure_path(@category, @expenditure)
        sleep(1)
        find('.back-icon').click
        sleep(1)
        expect(current_path).to eq(category_expenditures_path(@category))
      end

      it 'Delete expenditure action' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        visit category_expenditure_path(@category, @expenditure)
        sleep(1)
        click_button 'DELETE'
        sleep(1)
        expect(current_path).to eq(category_expenditures_path(@category))
      end
    end
end