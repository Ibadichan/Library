require 'acceptance/acceptance_helper'

feature 'User can sign in and sign up with facebook', '
  In order to register or sign in
  As an user
  I want to sign in/up with facebook
' do

  given(:user) { create(:user, email: mock_facebook_auth_hash.info.email) }

  scenario 'User has authorization' do
    user.authorizations.create(provider: mock_facebook_auth_hash.provider,
                               uid: mock_facebook_auth_hash.uid)
    visit new_user_session_path

    click_on 'Sign in with facebook'
    mock_facebook_auth_hash

    expect(page).to have_content 'Successfully authenticated from Facebook account.'
  end

  describe 'User has not authorization' do
    scenario 'User exists' do
      user
      visit new_user_session_path

      click_on 'Sign in with facebook'
      mock_facebook_auth_hash

      expect(page).to have_content 'Successfully authenticated from Facebook account.'
    end

    scenario 'User does not exist' do
      visit new_user_session_path

      click_on 'Sign in with facebook'
      mock_facebook_auth_hash

      expect(page).to have_content 'Successfully authenticated from Facebook account.'
    end
  end
end
