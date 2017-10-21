require 'acceptance/acceptance_helper'

feature 'User can put books in list', '
  In order to create plan
  As an authenticated user
  I want to put books in my list
' do

  given(:user) { create(:user) }

  scenario 'Guest tries to add book in list' do
    visit root_path
    expect(page).to_not have_link 'My Books'

    fill_in :query, with: 'Napoleon'
    click_on 'Search'

    expect(page).to_not have_link 'Add book in My Books'
  end

  scenario 'User tries to add book in list', js: true do
    sign_in user

    fill_in :query, with: 'Napoleon'
    click_on 'Search'

    within first('.book') do
      click_on 'Add book in My Books'
      expect(page).to have_content 'Book is added in favorites'
    end
  end
end
