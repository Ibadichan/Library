class UsersController < ApplicationController
  def finish_sign_up
    @user = User.find(params[:id])
    @user.update(email: user_params[:email]) if request.patch? && user_params[:email]
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
