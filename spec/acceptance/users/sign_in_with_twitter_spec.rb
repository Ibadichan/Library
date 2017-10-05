require 'acceptance/acceptance_helper'

feature 'User can sign in/up with Twitter', '
  In order to register or sign in
  As an authenticated user or guest
  I want to sign in/up with Twitter
' do

  given(:user)     { create(:user) }
  given(:provider) { mock_twitter_auth_hash.provider }
  given(:mock_provider_auth_hash) { mock_twitter_auth_hash }

  scenario 'User has authorization' do
    user.authorizations.create(provider: mock_twitter_auth_hash.provider,
                               uid: mock_twitter_auth_hash.uid)
    visit new_user_session_path

    click_on 'Sign in with twitter'
    mock_twitter_auth_hash

    expect(current_path).to eq root_path
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end

  describe 'User has not authorization' do
    it_behaves_like 'Registration with provider'
  end
end
