shared_examples_for 'Registration with provider' do
  scenario 'User exists' do
    user
    visit new_user_session_path

    click_on "Sign in with #{provider}"
    mock_provider_auth_hash

    expect(page).to have_content 'Please, add your email for verify account'
    fill_in :user_email, with: 'new@mail.com'
    click_on 'Post'

    open_email('new@mail.com')
    current_email.click_link 'Confirm my account'

    expect(page).to have_content 'Your email address has been successfully confirmed.'
    click_on "Sign in with #{provider}"

    expect(current_path).to eq root_path
    expect(page).to have_content "Successfully authenticated from #{provider.capitalize} account."
  end

  scenario 'User does not exist' do
    visit new_user_session_path

    click_on "Sign in with #{provider}"
    mock_provider_auth_hash

    expect(page).to have_content 'Please, add your email for verify account'
    fill_in :user_email, with: 'new@mail.com'
    click_on 'Post'

    open_email('new@mail.com')
    current_email.click_link 'Confirm my account'

    expect(page).to have_content 'Your email address has been successfully confirmed.'
    click_on "Sign in with #{provider}"

    expect(current_path).to eq root_path
    expect(page).to have_content "Successfully authenticated from #{provider.capitalize} account."
  end
end
