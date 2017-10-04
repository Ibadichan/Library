require 'acceptance/acceptance_helper'

feature 'User can sign out', '
  In order to finish session
  As an user
  I want to sign out
' do

  given(:user) { create(:user) }

  scenario 'User tries to sign out' do
    sign_in user

    click_on 'Sign out'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Guest tries to sign out' do
    visit new_user_session_path

    expect(page).to_not have_content 'Sign out'
  end
end
