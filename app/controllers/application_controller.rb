require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js, :json

  protect_from_forgery with: :exception

  before_action :ensure_sign_up_complete, unless: :devise_controller?

  def ensure_sign_up_complete
    return if action_name == 'finish_sign_up' || !current_user
    redirect_to finish_sign_up_path(current_user) unless current_user.email_verified?
  end
end
