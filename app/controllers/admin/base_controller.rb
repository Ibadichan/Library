class Admin::BaseController < ApplicationController
  before_action :check_admin
  skip_authorization_check

  protected

  def check_admin
    redirect_to root_path, alert: "You're not authorized to view this page" unless current_user.admin?
  end
end
