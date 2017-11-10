require 'acceptance/acceptance_helper'

feature 'User can see account of other user', '
  In order to see public plans of other users
  As authenticated user
  I want to see account of other user
' do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }

  scenario 'User tries to see account of other user' do
    sign_in user

    click_on 'Search Users'
    fill_in :q_name_or_email_cont, with: other_user.email
    click_on 'Search'

    click_on 'See this account'

    expect(page).to have_content other_user.email
    expect(page).to have_content other_user.name
    expect(find('#user-avatar')['src']).to have_content other_user.avatar.url
  end
end
