class FavoritesController < ApplicationController
  before_action :set_book, only: %i[create]
  skip_authorization_check only: %i[index]

  def index
    @books = current_user.books.page params[:page]
    respond_with @books
  end

  def create
    authorize! :add_in_favorites, @book
    respond_with current_user.books << @book
  end

  def destroy
    @book = Book.find(params[:id])
    authorize! :delete, @book
    respond_with @book.destroy
  end

  private

  def set_book
    @book = Book.find_by(google_book_id: params[:google_book_id])
    @book ||= Book.create(google_book_id: params[:google_book_id])
  end
end
