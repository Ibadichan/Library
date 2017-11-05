require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  sign_in_user

  let(:plan) { create(:plan, user: @user) }
  let(:book) { create(:book) }

  before { plan.books << book }

  describe 'POST #create' do
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

  describe 'DELETE #destroy' do
    before { @user.subscriptions.create(plans_book: book.plans_books.first) }

    it 'deletes the subscription of user' do
      expect do
        post :destroy, params: { user_id: @user, plan_id: plan, book_id: book,
                                 id: @user.subscriptions.last, format: :js }
      end.to change(@user.subscriptions, :count).by(-1)
    end

    it 'renders template destroy' do
      post :destroy, params: { user_id: @user, plan_id: plan, book_id: book,
                               id: @user.subscriptions.last, format: :js }
      expect(response).to render_template 'destroy'
    end
  end
end
