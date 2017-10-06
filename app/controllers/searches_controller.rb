class SearchesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_authorization_check

  def show
    render 'searches/welcome'
  end
end
