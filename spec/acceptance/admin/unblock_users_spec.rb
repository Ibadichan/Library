require 'acceptance/acceptance_helper'

feature 'Admin can unblock users', '
  In order to allow user to use app
  As an administrator
  I want to unblock user
' do

  given!(:user) { create(:user, blocked: true) }
  given(:admin) { create(:user, admin: true) }

  scenario 'Admin can unblock user', js: true do
    sign_in admin

    visit admin_users_path

    click_on 'Unblock User'

    expect(page).to_not have_link 'Unblock User'
    expect(page).to have_link 'Block User'
    expect(current_path).to eq admin_users_path
  end
end
