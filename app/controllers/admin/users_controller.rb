class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: %i[block unblock]

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
    respond_with @user.update(blocked: true), json: @user
  end

  def unblock
    respond_with @user.update(blocked: false), json: @user
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
  end
end
