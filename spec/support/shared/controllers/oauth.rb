shared_examples_for 'OAuthable' do
  it 'calls method find_for_oauth of User' do
    expect(User).to receive(:find_for_oauth).with(request.env['omniauth.auth']).and_call_original
    get provider
  end

  it 'assigns user to @user' do
    get provider
    expect(assigns(:user)).to be_a(User)
  end
end
