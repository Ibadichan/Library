require 'acceptance/acceptance_helper'

feature 'User can search books', '
  In order to add book in plan
  As an guest or authenticated user
  I want to be able search books
' do

  describe 'User tries to search books' do
    background do
      visit search_path
      expect(page).to have_content 'To search please enter the name of the book or the author.'
    end

    scenario 'Book exists' do
      fill_in :query, with: 'Napoleon'
      click_on 'Search'

      expect(page).to have_content 'Found results:'
      expect(page).to have_content 'Napoleon'
      expect(page).to have_content 'Authors: Georges Lefebvre'
      expect(page).to have_content 'With a new introduction by Andrew Roberts'
    end

    scenario 'Book does not exist' do
      fill_in :query, with: ''
      click_on 'Search'

      expect(page).to have_content 'No results found.'
    end
  end
end
