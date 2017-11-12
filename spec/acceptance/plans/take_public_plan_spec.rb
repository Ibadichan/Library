require 'acceptance/acceptance_helper'

feature 'User can take plan of other user', '
  In order to manage plan
  As an authenticated user
  I want to take public plan of other user
' do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:plan) { create(:plan, user: other_user, public: true) }
  given(:book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }

  background do
    plan.books << book
    sign_in user
    visit user_path(other_user)
  end

  scenario 'User tries to see public plan' do
    click_on 'See this plan'

    expect(page).to have_content plan.title
    expect(page).to have_content plan.description
    expect(page).to have_content 'Stalin'

    expect(page).to_not have_link 'Subscribe to book'
    expect(page).to_not have_link 'Mark book as readed'
  end

  scenario 'User tries to add public plan in own plans', js: true do
    Capybara.raise_server_errors = false

    click_on 'Add this plan in My Plans'

    expect(page).to_not have_link 'Add this plan in My Plans'
    expect(page).to have_content 'Plan is added'

    visit user_plan_path(user, Plan.last)

    expect(page).to have_content plan.title
    expect(page).to have_content plan.description
    expect(page).to have_content 'Stalin'
    expect(page).to have_link 'Mark book as readed'
    expect(page).to have_link 'Subscribe to book'
  end
end
