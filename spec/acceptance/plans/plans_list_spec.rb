require 'acceptance/acceptance_helper'

feature 'User can see own plans', '
  In order to create/delete plan
  As an authenticated user
  I want to see my list of plans
' do

  given(:user) { create(:user) }
  given!(:plan) { create(:plan, user: user) }

  scenario 'Guest tries to see Plans' do
    visit root_path

    expect(page).to_not have_link 'Plans'
  end

  scenario 'Authenticated user tries to see Plans' do
    sign_in user

    click_on 'My Plans'

    expect(page).to have_content 'Your Plans:'
    expect(page).to have_link plan.title
    expect(page).to have_content plan.description
  end
end
