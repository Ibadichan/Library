require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  before { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'GET #facebook' do
    before { request.env['omniauth.auth'] = mock_facebook_auth_hash }

    it 'calls method find_for_oauth of User' do
      expect(User).to receive(:find_for_oauth).with(request.env['omniauth.auth']).and_call_original
      get :facebook
    end

    it 'assigns user to @user' do
      get :facebook
      expect(assigns(:user)).to be_a(User)
    end
  end
end
