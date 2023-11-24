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

    context '#edit view' do
      it 'should direct to edit view' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        within(".category-container", text: @category.name) do
            click_button 'UPDATE'
        end
        sleep(1)
        fill_in 'Name', with: 'Updated Category one'
        click_button 'Update'
        sleep(1)
        expect(current_path).to eq(categories_path)
        expect(page).to have_content('Updated Category one');
      end

      it 'back action should take to categories view' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        within(".category-container", text: @category.name) do
            click_button 'UPDATE'
        end
        sleep(1)
        click_link 'Back'
        sleep(1)
        expect(current_path).to eq(categories_path)
      end
    end
end