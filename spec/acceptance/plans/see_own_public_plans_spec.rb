require 'acceptance/acceptance_helper'

feature 'User can see own public plans', '
  In order to see all public plans
  As an authenticated user
  I want to see own public plans
' do

  given(:user) { create(:user) }
  given!(:public_plan) { create(:plan, user: user, public: true) }
  given!(:private_plan) { create(:plan, user: user, public: false) }

  background { sign_in user }

  scenario 'User tries to see own public plans' do
    click_on 'My account'

    expect(page).to have_content 'Public plans'

    expect(page).to have_content public_plan.title.truncate(50)
    expect(page).to have_content public_plan.description.truncate(100)
    expect(page).to have_link 'See this plan'

    expect(page).to_not have_content private_plan.title.truncate(50)
    expect(page).to_not have_content private_plan.description.truncate(100)
  end

  scenario 'User tries to see own one public plan' do
    click_on 'My account'
    click_on 'See this plan'

    expect(page).to have_content public_plan.title
    expect(page).to have_content public_plan.description
    expect(page).to have_css('.progress')
  end
end
