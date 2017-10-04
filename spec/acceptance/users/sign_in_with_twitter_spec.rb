require 'acceptance/acceptance_helper'

feature 'User can sign in/up with Twitter', '
  In order to register or sign in
  As an authenticated user or guest
  I want to sign in/up with Twitter
' do

  given(:user) { create(:user) }

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
    scenario 'User exists' do
      user
      visit new_user_session_path

      click_on 'Sign in with twitter'
      mock_twitter_auth_hash

      expect(page).to have_content 'Please, add your email for verify account'
      fill_in 'Email', with: 'new@mail.com'
      click_on 'Post'

      open_email('new@mail.com')
      current_email.click_link 'Confirm my account'

      expect(page).to have_content 'Your email address has been successfully confirmed.'
      click_on 'Sign in with twitter'

      expect(current_path).to eq root_path
      expect(page).to have_content 'Successfully authenticated from Twitter account.'
    end

    scenario 'User does not exist' do
      visit new_user_session_path

      click_on 'Sign in with twitter'
      mock_twitter_auth_hash

      expect(page).to have_content 'Please, add your email for verify account'
      fill_in 'Email', with: 'new@mail.com'
      click_on 'Post'

      open_email('new@mail.com')
      current_email.click_link 'Confirm my account'

      expect(page).to have_content 'Your email address has been successfully confirmed.'
      click_on 'Sign in with twitter'

      expect(current_path).to eq root_path
      expect(page).to have_content 'Successfully authenticated from Twitter account.'
    end
  end
end
