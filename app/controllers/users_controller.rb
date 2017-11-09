class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @public_plans = @user.plans.where(public: true).page params[:page]
  end

  def finish_sign_up
    respond_with @user.update(email: user_params[:email]) if request.patch? && user_params[:email]
  end

  def search_others_users
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page params[:page]
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
