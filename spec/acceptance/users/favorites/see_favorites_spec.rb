require 'acceptance/acceptance_helper'

feature 'User can see own list of books', '
  In order to delete book or create plan
  As an authenticated user
  I want to see my favorites
' do

  given(:user) { create(:user) }
  given(:book) { create(:book, google_book_id: 'N9mbl_xbWpkC') }

  scenario 'Guest tries to see my books' do
    visit root_path

    expect(page).to_not have_link 'My Books'
  end

  scenario 'User tries to see my books' do
    sign_in user
    user.books << book

    click_on 'My Books'
    expect(page).to have_content 'Lenin'
    expect(page).to have_content 'Robert Service'
    expect(page).to have_content '2011-02-21'
    expect(page)
      .to have_content 'Lenin is a colossal figure whose influence on
                        twentieth-century history cannot be underestimated.'
    expect(page).to have_css('img')
  end
end
