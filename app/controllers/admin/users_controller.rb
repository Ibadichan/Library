class Admin::UsersController < Admin::BaseController
  def new
    respond_with @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!

    if @user.save
      redirect_to admin_root_path, notice: 'User is created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
  end
end
