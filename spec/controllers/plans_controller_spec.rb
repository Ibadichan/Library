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

  describe 'GET #show' do
    let(:plan) { create(:plan, user: @user) }

    before { get :show, params: { user_id: @user, id: plan } }

    it 'assigns requested plan to @plan' do
      expect(assigns(:plan)).to eq plan
    end

    it 'renders template show' do
      expect(response).to render_template 'show'
    end
  end

  describe 'GET #new' do
    before { get :new, params: { user_id: @user } }

    it 'assigns a new plan to @plan' do
      expect(assigns(:plan)).to be_a_new(Plan)
    end

    it 'renders template new' do
      expect(response).to render_template 'new'
    end
  end

  describe 'POST #create' do
    context 'plan is valid' do
      it 'changes count of plans' do
        expect do
          post :create, params: { user_id: @user, plan: attributes_for(:plan) }
        end.to change(@user.plans, :count).by(1)
      end

      it 'redirects to show' do
        post :create, params: { user_id: @user, plan: attributes_for(:plan) }
        expect(response).to redirect_to [@user, Plan.last]
      end
    end

    context 'plan is invalid' do
      it 'does not change count of plans' do
        expect do
          post :create, params: { user_id: @user, plan: attributes_for(:invalid_plan) }
        end.to_not change(@user.plans, :count)
      end

      it 'renders new template' do
        post :create, params: { user_id: @user, plan: attributes_for(:invalid_plan) }
        expect(response).to render_template 'new'
      end
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
