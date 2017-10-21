class FavoritesController < ApplicationController
  before_action :set_book, only: %i[create]

  def index
    @books = current_user.books.page params[:page]
    @books.each { |book| authorize! :read, book }
    respond_with @books
  end

  def create
    authorize! :add_in_favorites, @book
    respond_with current_user.books << @book
  end

  private

  def set_book
    @book = Book.find_by(google_book_id: params[:google_book_id])
    @book ||= Book.create(google_book_id: params[:google_book_id])
  end
end
