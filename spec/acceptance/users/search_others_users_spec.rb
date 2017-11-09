require 'acceptance/acceptance_helper'

feature 'User can search other users', '
  In order to take public plans
  As an authenticated user
  I want to search users
' do

  given!(:user) { create(:user) }
  given!(:others_users) { create_list(:user, 2) }

  scenario 'Guest tries to search others users' do
    visit root_path

    expect(page).to_not have_link 'Search Users'
  end

  scenario 'Authenticated user tries to search others users' do
    sign_in user

    click_on 'Search Users'
    expect(page).to have_content 'Please, enter email or name of user to search'

    fill_in :q_name_or_email_cont, with: others_users.first.email
    click_on 'Search'

    expect(page).to have_content others_users.first.email
    expect(page).to have_content others_users.first.name

    expect(page).to_not have_content others_users.last.email
    expect(page).to_not have_content others_users.last.name

    expect(page).to have_link 'See this account'
  end
end
