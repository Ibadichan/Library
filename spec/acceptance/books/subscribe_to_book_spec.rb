require 'acceptance/acceptance_helper'

feature 'User can subscribe to book', '
  In order to get notification
  As an author of book and plan
  I want to subscribe to book
' do

  given(:user) { create(:user) }
  given(:plan) { create(:plan, user: user) }
  given(:book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }

  scenario 'User can subscribe to book', js: true do
    user.books << book
    plan.books << book
    sign_in user

    visit user_plan_path(user, plan)

    within '.book' do
      click_on 'Subscribe to book'
      expect(page).to_not have_link 'Subscribe to book'
      expect(page).to have_link 'Unsubscribe from book'
    end
  end
end
