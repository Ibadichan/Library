require 'rails_helper'

RSpec.describe Admin::PanelsController, type: :controller do
  describe 'GET #show' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end

    context 'Admin tries to see panel' do
      let(:user) { create(:user, admin: true) }

      it 'renders show template' do
        get :show
        expect(response).to render_template 'show'
      end
    end

    context 'Non-Admin tries to see panel' do
      let(:user) { create(:user, admin: false) }

      it 'redirects to root path' do
        get :show
        expect(response).to redirect_to root_path
      end
    end
  end
end
