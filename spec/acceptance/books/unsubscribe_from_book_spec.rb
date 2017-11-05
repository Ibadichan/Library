require 'acceptance/acceptance_helper'

feature 'User can unsubscribe from book', '
  In order to stop get notification
  As an authenticated user
  I want to unsubscribe from book
' do

  given(:user) { create(:user) }
  given(:plan) { create(:plan, user: user) }
  given(:book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }

  scenario 'User can unsubscribe from book', js: true do
    user.books << book
    plan.books << book
    user.subscriptions.create(plans_book: book.plans_books.first)

    sign_in user

    visit user_plan_path(user, plan)

    within '.book' do
      click_on 'Unsubscribe from book'
      expect(page).to have_link 'Subscribe to book'
      expect(page).to_not have_link 'Unsubscribe from book'
    end
  end
end
