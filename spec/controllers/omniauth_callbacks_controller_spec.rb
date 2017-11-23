require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
  before { @request.env['devise.mapping'] = Devise.mappings[:user] }

  RSpec.shared_examples_for 'OAuthable' do
    it 'calls method find_for_oauth of User' do
      expect(User).to receive(:find_for_oauth).with(request.env['omniauth.auth']).and_call_original
      get provider
    end

    it 'assigns user to @user' do
      get provider
      expect(assigns(:user)).to be_a(User)
    end
  end

  describe 'GET #facebook' do
    before { request.env['omniauth.auth'] = mock_facebook_auth_hash }
    let(:provider) { mock_facebook_auth_hash.provider.to_sym }

    it_behaves_like 'OAuthable'

    it 'redirects to root path' do
      get :facebook
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #twitter' do
    before { request.env['omniauth.auth'] = mock_twitter_auth_hash }
    let(:provider) { mock_twitter_auth_hash.provider.to_sym }

    context 'Email is verified' do
      let(:user) { create(:user) }
      let!(:authorization) do
        create(:authorization, provider: mock_twitter_auth_hash.provider,
                               uid: mock_twitter_auth_hash.uid, user: user)
      end

      it_behaves_like 'OAuthable'

      it 'redirects to root path' do
        get :twitter
        expect(response).to redirect_to root_path
      end
    end

    context 'Email is not verified' do
      it_behaves_like 'OAuthable'

      it 'redirects to finish sign up path' do
        get :twitter
        expect(response).to redirect_to finish_sign_up_path(assigns(:user))
      end
    end
  end

  describe 'GET #vkontakte' do
    before { request.env['omniauth.auth'] = mock_vkontakte_auth_hash }
    let(:provider) { mock_vkontakte_auth_hash.provider.to_sym }

    context 'Email is verified' do
      let(:user) { create(:user) }
      let!(:authorization) do
        create(:authorization, provider: mock_vkontakte_auth_hash.provider,
                               uid: mock_vkontakte_auth_hash.uid, user: user)
      end

      it_behaves_like 'OAuthable'

      it 'redirects to root path' do
        get :vkontakte
        expect(response).to redirect_to root_path
      end
    end

    context 'Email is not verified' do
      it_behaves_like 'OAuthable'

      it 'redirects to finish sign up path' do
        get :vkontakte
        expect(response).to redirect_to finish_sign_up_path(assigns(:user))
      end
    end
  end
end
