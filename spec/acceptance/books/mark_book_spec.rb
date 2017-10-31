require 'acceptance/acceptance_helper'

feature 'User can mark book as readed', '
  In order to know how many books left
  As an authenticated user
  I want to mark book
' do

  given(:user) { create(:user) }
  given(:plan) { create(:plan, user: user) }
  given(:book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }

  scenario 'User tries to mark book', js: true do
    user.books << book
    plan.books << book
    sign_in user

    click_on 'My Plans'
    click_on plan.title

    click_on 'Mark book as readed'
    expect(page).to_not have_link 'Mark book as readed'
    expect(page).to have_content 'Book is readed'
  end
end
