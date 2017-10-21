require 'acceptance/acceptance_helper'

feature 'User can sign in', '
  In order to search book
  As an authenticated user
  I want to sign in
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign in' do
    sign_in user

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Guest tries to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: '********'
    click_on 'Log in'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Invalid Email or password.'
  end
end
