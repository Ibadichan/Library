class BooksController < ApplicationController
  before_action :set_book, only: %i[add_in_favorites]
  skip_authorization_check only: %i[index mark]
  load_resource
  authorize_resource except: %i[index mark]
  before_action :load_plan_and_check_access, only: %i[mark]

  def index
    @books = current_user.books.page params[:page]
    respond_with @books
  end

  def add_in_favorites
    respond_with current_user.books << @book
  end

  def destroy
    respond_with current_user.books.delete(@book)
  end

  def mark
    respond_with @plan.update_marked_field_for(@book)
  end

  private

  def load_plan_and_check_access
    @plan = Plan.friendly.find(params[:plan_id])
    head :forbidden if @book.readed_in?(@plan) || @plan.user != current_user
  end

  def set_book
    @book = Book.find_by(google_book_id: params[:google_book_id])
    @book ||= Book.create(google_book_id: params[:google_book_id])
  end
end
