require 'rails_helper'

RSpec.describe 'Category', type: :system do
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

    context 'User logs in successfully' do
        it 'should redirect to the authenticated root path' do
            visit new_user_session_path
            sleep(1)

            fill_in 'Email', with: @user.email
            fill_in 'Password', with: @user.password

            click_button 'Log in'
            sleep(1)
            expect(current_path).to eq(authenticated_root_path)
            expect(page).to have_content('Signed in successfully.')
        end
    end

    context '#index view' do
      it 'should direct to categories index' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        expect(page).to have_content('Category one');
        expect(page).to have_content('Add new Category');
        expect(page).to have_content('UPDATE');
        expect(page).to have_content('DELETE');
        expect(page).to have_content('2023');
        expect(page).to have_content("$ #{@category.expenditures_sum}");
      end

      it 'DELETE action should remove content' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        sleep(1)
        within(".category-container", text: @category2.name) do
            click_button 'DELETE'
        end

        sleep(1)
        expect(page).not_to have_content(@category2.name)
      end
    end

    context 'action redirections' do
        it 'should redirect to new category page' do
            visit new_user_session_path
            fill_in 'Email', with: @user.email
            fill_in 'Password', with: @user.password
            click_button 'Log in'
            sleep(1)  
            click_link 'Add new Category'
            sleep(1)
            expect(current_path).to eq(new_category_path)
        end

        it 'category link should take to expenditures view' do
            visit new_user_session_path
            fill_in 'Email', with: @user.email
            fill_in 'Password', with: @user.password
            click_button 'Log in'
            sleep(1)
            within(".category-container", text: @category.name) do
                click_link @category.name
            end
            sleep(1)
            expect(current_path).to eq(category_expenditures_path(@category))
        end
    end
end