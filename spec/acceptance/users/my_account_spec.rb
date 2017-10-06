require 'acceptance/acceptance_helper'

feature 'User can see own account', '
  In order to see my info
  As an author of account
  I want to see my profile
' do

  given(:user) { create(:user) }

  scenario 'Guest tries to click on My Account' do
    visit root_path
    expect(page).to have_no_link 'My Account'
  end

  scenario 'User tries to see own account' do
    sign_in user

    click_on 'My account'

    expect(current_path).to eq user_path(user)
    expect(page).to have_content user.email
    expect(page).to have_content user.name
  end
end
