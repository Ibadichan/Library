require 'acceptance/acceptance_helper'

feature 'User can create plan', '
  In order to conveniently read books
  As an authenticated user
  I want to create plan
' do

  given(:user) { create(:user) }
  given(:first_book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }
  given(:second_book) { create(:book, google_book_id: 'iNZgBQAAQBAJ') }

  scenario 'User tries to create plan' do
    user.books << second_book << first_book
    sign_in user

    click_on 'My Plans'
    click_on 'Add new Plan'

    fill_in 'Title', with: 'my title'
    fill_in 'Description', with: 'my description'

    select = page.find('select')
    select.select 'Stalin, published_at: 2008-09-04, authors: Robert Service'
    select.select 'Napoleon, published_at: 2011-10-27, authors: Alan Forrest'

    click_on 'Create'

    expect(current_path).to eq user_plan_path(user, Plan.last)
    expect(page).to have_content 'Plan was successfully created.'
    expect(page).to have_content 'my title'
    expect(page).to have_content 'my description'
    expect(page).to have_content 'Napoleon'
    expect(page).to have_content 'Stalin'
  end
end
