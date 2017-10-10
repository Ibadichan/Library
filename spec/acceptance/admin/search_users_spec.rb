require 'acceptance/acceptance_helper'

feature 'Admin can search users', '
  In order to block/unblock user
  As an administrator
  I want to search users
' do

  given!(:users)     { create_list(:user, 2, admin: false) }
  given(:admin)      { create(:user, admin: true) }

  scenario 'Guest tries to search' do
    visit admin_users_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Not-Admin tries to search' do
    sign_in users.first

    visit admin_users_path

    expect(current_path).to eq root_path
    expect(page).to have_content "You're not authorized to view this page"
  end

  scenario 'Admin tries to search' do
    sign_in admin

    visit admin_users_path

    users.each do |user|
      %w[name email id].each { |attr| expect(page).to have_content user.send(attr.to_sym) }
    end

    fill_in :q_name_or_email_cont, with: users.first.email
    click_on 'Search'

    %w[name email id].each { |attr| expect(page).to have_content users.first.send(attr.to_sym) }
    %w[name email id].each { |attr| expect(page).to_not have_content users.last.send(attr.to_sym) }

    expect(current_path).to eq admin_users_path
  end
end
