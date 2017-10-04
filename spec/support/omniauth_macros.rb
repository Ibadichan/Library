module OmniauthMacros
  def mock_facebook_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook', uid: '1235456', info: { email: 'test@example.com' }
    )
  end
end
