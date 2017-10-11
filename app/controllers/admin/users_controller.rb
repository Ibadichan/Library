class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(id: :asc).page params[:page]
  end

  def new
    respond_with @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    @user.save
    respond_with @user, location: -> { admin_users_path }
  end

  def block
    @user = User.find(params[:id])
    respond_with @user.update(blocked: true)
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
  end
end
