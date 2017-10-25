require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  sign_in_user

  describe 'POST #add_in_favorites' do
    RSpec.shared_examples 'adding books to books' do
      it 'add book in books of user' do
        expect do
          post :add_in_favorites, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        end.to change(@user.books, :count).by(1)
      end

      it 'renders create view' do
        post :add_in_favorites, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        expect(response).to render_template 'add_in_favorites'
      end
    end

    context 'book exists' do
      let(:book) { create(:book) }
      let(:google_book_id) { book.google_book_id }

      it 'finds book by google_book_id' do
        post :add_in_favorites, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        expect(assigns(:book)).to eq book
      end

      it_behaves_like 'adding books to books'
    end

    context 'book does not exist' do
      let(:google_book_id) { Devise.friendly_token[0, 20] }

      it 'assigns created book to @book' do
        post :add_in_favorites, params: { user_id: @user, google_book_id: google_book_id, format: :js }
        expect(assigns(:book).google_book_id).to eq google_book_id
      end

      it_behaves_like 'adding books to books'
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

  describe 'DELETE #destroy' do
    let(:book) { create(:book) }

    before { @user.books << book }

    it 'deletes book' do
      expect do
        delete :destroy, params: { user_id: @user, id: book, format: :js }
      end.to change(@user.books, :count).by(-1)
    end

    it 'renders template destroy' do
      delete :destroy, params: { user_id: @user, id: book, format: :js }
      expect(response).to render_template 'destroy'
    end
  end
end
