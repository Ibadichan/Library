require 'acceptance/acceptance_helper'

feature 'User can edit own profile', '
  In order to update account
  As an user of account
  I want to edit my profile
' do

  given!(:user) { create(:user) }

  scenario 'Guest tries to edit account' do
    visit edit_user_registration_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Guest tries to edit own account' do
    sign_in user

    click_on 'My account'
    click_on 'Edit Profile'

    attach_file 'Avatar', "#{Rails.root}/Gemfile"
    fill_in 'Name', with: 'NewName'
    fill_in 'Email', with: 'new@gmail.com'
    fill_in 'Password', with: '1234567'
    fill_in 'Password confirmation', with: '1234567'
    fill_in 'Current password', with: user.password

    click_on 'Update'

    open_email 'new@gmail.com'
    current_email.click_link 'Confirm my account'

    user.reload

    expect(user.email).to eq 'new@gmail.com'
    expect(user.name).to eq 'NewName'
    expect(user.avatar.url).to eq "#{Rails.root}/spec/support/uploads/user/avatar/2/Gemfile"
    expect(user.valid_password?('1234567')).to eq true
  end
end
