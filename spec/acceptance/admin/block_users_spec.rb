require 'acceptance/acceptance_helper'

feature 'Admin can block users', '
  In order to close access to application
  As an administrator
  I want to block users
' do

  given(:admin) { create(:user, admin: true) }
  given(:user) { create(:user) }

  scenario 'Admin tries to block users', js: true do
    sign_in admin

    visit admin_users_path
    click_on 'Block User'

    expect(page).to_not have_link 'Block User'
    expect(page).to have_link 'Unblock User'
    expect(current_path).to eq admin_users_path
  end
end
