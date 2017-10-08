require 'acceptance/acceptance_helper'

feature 'Admin can see admin panel', '
  In order to manage app
  As an administrator
  I want to see admin panel
' do

  given(:user)  { create(:user, admin: false) }
  given(:admin) { create(:user, admin: true)  }

  scenario 'Guest tries to see panel' do
    visit root_path
    expect(page).to have_no_link 'Admin Panel'
  end

  scenario 'User tries to see panel' do
    sign_in user

    visit root_path
    expect(page).to have_no_link 'Admin Panel'
  end

  scenario 'Admin tries see panel' do
    sign_in admin

    visit root_path

    click_on 'Admin Panel'

    expect(page).to have_content 'Welcome to the admin panel'
    expect(current_path).to eq admin_root_path
  end
end
