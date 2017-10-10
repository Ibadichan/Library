require 'acceptance/acceptance_helper'

feature 'Admin can create user', '
  In order to register user
  As an administrator
  I want to create user
' do

  given(:admin) { create(:user, admin: true) }

  describe 'Admin tries to create user' do
    before do
      sign_in admin
      visit new_admin_user_path
    end

    scenario 'with valid attributes' do
      attach_file 'Avatar', "#{Rails.root}/.rspec"
      fill_in 'Name', with: 'Ivan'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Create'

      expect(page).to have_content 'User was successfully created.'
      expect(current_path).to eq admin_users_path
    end

    scenario 'with invalid attributes' do
      click_on 'Create'

      expect(page).to have_content "name can't be blank"
      expect(page).to have_content "email can't be blank"
      expect(page).to have_content "password can't be blank"
      expect(page).to have_content "avatar can't be blank"
    end
  end
end
