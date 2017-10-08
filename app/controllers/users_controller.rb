class UsersController < ApplicationController
  load_and_authorize_resource

  def show; end

  def finish_sign_up
    respond_with @user.update(email: user_params[:email]) if request.patch? && user_params[:email]
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
