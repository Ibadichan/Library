require 'acceptance/acceptance_helper'

feature 'User can mark plan as public', '
  In order to share plan
  As an authenticated user
  I want to mark plan as public
' do

  given(:user) { create(:user) }
  given!(:plan) { create(:plan, user: user) }

  scenario 'User tries to mark plan', js: true do
    sign_in user

    click_on 'My Plans'
    click_on 'Make the plan public'

    expect(page).to_not have_link 'Make the plan public'
    expect(page).to have_link 'Make the plan private'
  end
end
