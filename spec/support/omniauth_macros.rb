module OmniauthMacros
  def mock_facebook_auth_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook', uid: '123456', info: { email: 'test@example.com' }
    )
  end

  def mock_twitter_auth_hash
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '123456', info: { name: 'Ivan' },
      credentials: {
        token: 'mock_token',
        secret: 'mock_secret'
      }
    )
  end
end
