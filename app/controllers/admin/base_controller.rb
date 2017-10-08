class Admin::BaseController < ApplicationController
  before_action :check_admin

  protected

  def check_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You are not authorized to view this page'
    end
  end
end
