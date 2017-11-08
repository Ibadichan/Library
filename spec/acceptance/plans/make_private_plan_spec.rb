require 'acceptance/acceptance_helper'

feature 'User can mark plan as private', '
  In order to close access
  As an authenticated user
  I want to mark plan as private
' do

  given(:user) { create(:user) }
  given!(:plan) { create(:plan, user: user, public: true) }

  scenario 'User tries to mark plan', js: true do
    sign_in user

    click_on 'My Plans'
    click_on 'Make the plan private'

    expect(page).to_not have_link 'Make the plan private'
    expect(page).to have_link 'Make the plan public'
  end
end
