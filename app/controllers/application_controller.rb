require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :blocked?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_sign_up_complete, unless: :devise_controller?
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def blocked?
    return unless current_user&.blocked?
    sign_out current_user
    redirect_to root_path, notice: 'This account has been suspended....'
  end

  def ensure_sign_up_complete
    return if action_name == 'finish_sign_up' || !current_user
    redirect_to finish_sign_up_path(current_user) unless current_user.email_verified?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
end
