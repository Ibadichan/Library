require 'acceptance/acceptance_helper'

feature 'User can delete own plan', '
  In order to clear list of plans
  As an authenticated user
  I want to delete my plan
' do

  given(:user) { create(:user) }
  given!(:plan) { create(:plan, user: user) }

  scenario 'User tries to delete own plan', js: true do
    sign_in user

    click_on 'My Plans'
    click_on 'Delete'

    expect(page).to_not have_content plan.description
    expect(page).to_not have_link plan.title
    expect(page).to_not have_link 'Delete'
  end
end
