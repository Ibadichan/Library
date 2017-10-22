class PlansController < ApplicationController
  skip_authorization_check only: %i[index]

  def index
    respond_with @plans = current_user.plans
  end
end
