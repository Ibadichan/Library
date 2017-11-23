require 'acceptance/acceptance_helper'

feature 'User can see plan', '
  In order to see plan/books information
  As an authenticated user
  I want to see plan
' do

  given(:user) { create(:user) }
  given(:plan) { create(:plan, user: user) }
  given(:book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }

  scenario 'User tries to see plan' do
    user.books << book
    plan.books << book
    sign_in user

    click_on 'My Plans'
    click_on plan.title

    expect(page).to have_content plan.title
    expect(page).to have_content plan.description
    expect(page).to have_css('.progress')
    expect(page).to have_content 'Stalin'
    expect(page).to have_link 'Mark book as readed'
  end
end
