require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  sign_in_user

  describe 'GET #index' do
    let(:plans) { create_list(:plan, 2, user: @user) }

    before { get :index, params: { user_id: @user } }

    it 'assigns all plans of user to @plans' do
      expect(assigns(:plans)).to eq plans
    end

    it 'renders template index' do
      expect(response).to render_template 'index'
    end
  end

  describe 'DELETE #destroy' do
    let!(:plan) { create(:plan, user: @user) }

    it 'destroys plan of user' do
      expect do
        delete :destroy, params: { user_id: @user, id: plan, format: :js }
      end.to change(@user.plans, :count).by(-1)
    end

    it 'renders template destroy' do
      delete :destroy, params: { user_id: @user, id: plan, format: :js }
      expect(response).to render_template 'destroy'
    end
  end
end
