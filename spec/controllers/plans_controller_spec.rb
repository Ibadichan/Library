require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  sign_in_user

  describe 'GET #index' do
    let(:plans) { create_list(:plan, 2, user: @user) }

    before { get :index, params: { user_id: @user } }

    it 'assigns all plans of user to @plans' do
      expect(assigns(:plans)).to match_array plans
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

  describe 'GET #edit' do
    let(:plan) { create(:plan, user: @user) }

    before { get :edit, params: { id: plan, user_id: @user } }

    it 'assigns requested plan to @plan' do
      expect(assigns(:plan)).to eq plan
    end

    it 'renders edit template' do
      expect(response).to render_template 'edit'
    end
  end

  describe 'PATCH #update' do
    let(:plan) { create(:plan, user: @user, title: 'title', description: 'desc') }

    context 'attributes are invalid' do
      before do
        patch :update,
              params: { id: plan, user_id: @user, plan: { description: nil, title: 'new title' } }
      end

      it 'assigns the requested plan to @plan' do
        expect(assigns(:plan)).to eq plan
      end

      it 'does not update plan' do
        plan.reload

        expect(plan.title).to eq 'title'
        expect(plan.description).to eq 'desc'
      end

      it 'renders edit template' do
        expect(response).to render_template 'edit'
      end
    end

    context 'attributes are valid' do
      before do
        patch :update,
              params: { id: plan, user_id: @user, plan: { description: 'new desc', title: 'new title' } }
      end

      it 'assigns the requested plan to @plan' do
        expect(assigns(:plan)).to eq plan
      end

      it 'updates plan' do
        plan.reload

        expect(plan.title).to eq 'new title'
        expect(plan.description).to eq 'new desc'
      end

      it 'redirects to plan' do
        expect(response).to redirect_to user_plan_path(@user, plan)
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

  describe 'PATCH #share' do
    let!(:plan) { create(:plan, user: @user, public: false) }

    before { patch :share, params: { user_id: @user, id: plan, format: :js } }

    it 'changes field public to true' do
      plan.reload
      expect(plan.public).to eq true
    end

    it 'renders share.js.erb template' do
      expect(response).to render_template 'share'
    end
  end

  describe 'PATCH #make_private' do
    let!(:plan) { create(:plan, user: @user, public: true) }

    before { patch :make_private, params: { user_id: @user, id: plan, format: :js } }

    it 'changes field public to false' do
      plan.reload
      expect(plan.public).to eq false
    end

    it 'renders make_private.js.erb template' do
      expect(response).to render_template 'make_private'
    end
  end

  describe 'POST #take' do
    let(:other_user) { create(:user) }
    let!(:plan) { create(:plan, user: other_user, public: true) }

    it 'creates a new plan for current_user' do
      expect do
        post :take, params: { user_id: other_user, id: plan, format: :js }
      end.to change(@user.plans, :count).by(1)
    end

    it 'does not create plan for author' do
      expect do
        post :take, params: { user_id: other_user, id: plan, format: :js }
      end.to_not change(other_user.plans, :count)
    end

    it 'renders take.js.erb template' do
      post :take, params: { user_id: other_user, id: plan, format: :js }
      expect(response).to render_template 'take'
    end
  end
end
