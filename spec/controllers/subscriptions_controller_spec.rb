require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  sign_in_user

  describe 'POST #create' do
    let(:plan) { create(:plan, user: @user) }
    let(:book) { create(:book) }

    before { plan.books << book }

    it 'creates a new subscription for user' do
      expect do
        post :create, params: { user_id: @user, plan_id: plan, book_id: book, format: :js }
      end.to change(@user.subscriptions, :count).by(1)
    end

    it 'renders create.js.erb template' do
      post :create, params: { user_id: @user, plan_id: plan, book_id: book, format: :js }
      expect(response).to render_template 'create'
    end
  end
end
