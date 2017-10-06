require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  sign_in_user

  describe 'PATCH #finish_sign_up' do
    it 'updates user email' do
      patch :finish_sign_up, params: { id: @user.id, user: { email: 'test@example.com' } }

      @user.reload
      expect(assigns(:user).unconfirmed_email).to eq 'test@example.com'
    end
  end

  describe 'GET #finish_sign_up' do
    it 'renders template finish_sign_up' do
      get :finish_sign_up, params: { id: @user.id }
      expect(response).to render_template 'finish_sign_up'
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, params: { id: @user.id }
      expect(response).to render_template 'show'
    end
  end
end
