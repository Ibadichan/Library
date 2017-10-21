require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  sign_in_user

  describe 'POST #create' do
    RSpec.shared_examples 'adding books to favorites' do
      it 'add book in books of user' do
        expect do
          post :create, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        end.to change(@user.books, :count).by(1)
      end

      it 'renders create view' do
        post :create, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        expect(response).to render_template 'create'
      end
    end

    context 'book exists' do
      let(:book) { create(:book) }
      let(:google_book_id) { book.google_book_id }

      it 'finds book by google_book_id' do
        post :create, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        expect(assigns(:book)).to eq book
      end

      it_behaves_like 'adding books to favorites'
    end

    context 'book does not exist' do
      let(:google_book_id) { Devise.friendly_token[0, 20] }

      it 'assigns created book to @book' do
        post :create, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        expect(assigns(:book).google_book_id).to eq google_book_id
      end

      it_behaves_like 'adding books to favorites'
    end
  end

  describe 'GET #index' do
    let(:books) { create_list(:book, 2) }

    before do
      books.each { |book| @user.books << book }
      get :index, params: { user_id: @user }
    end

    it 'populates an array of user books' do
      expect(assigns(:books)).to eq books
    end

    it 'renders index view' do
      expect(response).to render_template 'index'
    end
  end
end
