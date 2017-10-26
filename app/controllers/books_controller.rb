class BooksController < ApplicationController
  before_action :set_book, only: %i[add_in_favorites]
  skip_authorization_check only: %i[index]
  load_and_authorize_resource except: %i[index]

  def index
    @books = current_user.books.page params[:page]
    respond_with @books
  end

  def add_in_favorites
    respond_with current_user.books << @book
  end

  def destroy
    respond_with @book.destroy
  end

  def mark
    respond_with @book.update(marked: true)
  end

  private

  def set_book
    @book = Book.find_by(google_book_id: params[:google_book_id])
    @book ||= Book.create(google_book_id: params[:google_book_id])
  end
end
