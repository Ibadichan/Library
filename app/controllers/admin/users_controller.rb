class Admin::UsersController < Admin::BaseController
  def new
    respond_with @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    @user.save
    respond_with @user, location: -> { admin_users_path }
  end

  def index; end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
  end
end
