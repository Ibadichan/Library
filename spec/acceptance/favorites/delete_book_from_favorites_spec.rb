require 'acceptance/acceptance_helper'

feature 'User can delete book from favorites', '
  In order to destroy unnecessary book
  As an authenticated user
  I want to delete book
' do

  given(:user) { create(:user) }
  given(:book) { create(:book, google_book_id: 'N9mbl_xbWpkC') }

  scenario 'User tries to delete book', js: true do
    sign_in user
    user.books << book

    click_on 'My Books'

    click_on 'Delete'
    expect(page).to_not have_content 'Lenin'
    expect(page).to_not have_content 'Robert Service'
    expect(page).to_not have_content '2011-02-21'
    expect(page).to_not have_content 'Lenin is a colossal figure whose influence on
                                      twentieth-century history cannot be underestimated.'
    expect(page).to_not have_css('img')
  end
end
