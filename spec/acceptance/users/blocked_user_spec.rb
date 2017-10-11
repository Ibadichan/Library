require 'acceptance/acceptance_helper'

feature 'Blocked tries to use app', '
  In order to find books
  As an blocked user
  I want to use app
' do

  given(:user) { create(:user, blocked: true) }

  scenario 'Blocked user tries to use app' do
    sign_in user

    expect(current_path).to eq root_path
    expect(page).to have_content 'This account has been suspended....'
  end
end
