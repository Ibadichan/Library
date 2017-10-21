require 'acceptance/acceptance_helper'

feature 'User can sign in/up with vkontakte', '
  In order to register or sign in
  As guest or authenticated user
  I want to sign in/up with vkontakte
' do

  given(:user)     { create(:user) }
  given(:provider) { mock_vkontakte_auth_hash.provider }
  given(:mock_provider_auth_hash) { mock_vkontakte_auth_hash }

  scenario 'User has authorization' do
    user.authorizations.create(provider: mock_vkontakte_auth_hash.provider,
                               uid: mock_vkontakte_auth_hash.uid)
    visit new_user_session_path

    click_on 'Sign in with vkontakte'
    mock_vkontakte_auth_hash

    expect(current_path).to eq root_path
    expect(page).to have_content 'Successfully authenticated from Vkontakte account.'
  end

  describe 'User has not authorization' do
    it_behaves_like 'Registration with provider'
  end
end
