class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_before_action :blocked?, only: :show
  skip_authorization_check

  def show
    respond_with @books = Search.find_book(params[:query]) if params[:query].present?
  end
end
