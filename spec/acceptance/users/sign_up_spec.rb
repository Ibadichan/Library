require 'acceptance/acceptance_helper'

feature 'User can sign up', '
  In order to use the app
  As an user
  I want to register
' do

  scenario 'User tries to register' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    open_email 'test@example.com'
    current_email.click_link 'Confirm my account'

    expect(page).to have_content 'Your email address has been successfully confirmed.'
  end
end
