require 'acceptance/acceptance_helper'

feature 'Admin can sees admin panel', '
  In order to manage app
  As an administrator
  I want to see admin panel
' do

  given(:not_admin)  { create(:user, admin: false) }
  given(:admin)      { create(:user, admin: true)  }

  scenario 'Guest tries to see panel' do
    visit root_path
    expect(page).to have_no_link 'Admin Panel'
  end

  scenario 'Not-admin tries to see panel' do
    sign_in not_admin

    expect(page).to have_no_link 'Admin Panel'
  end

  scenario 'Admin tries to see panel' do
    sign_in admin

    click_on 'Admin Panel'

    expect(page).to have_content 'Welcome to the admin panel'
    expect(current_path).to eq admin_root_path
  end
end
