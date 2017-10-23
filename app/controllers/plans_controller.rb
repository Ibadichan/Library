class PlansController < ApplicationController
  load_and_authorize_resource except: %i[index]
  skip_authorization_check only: %i[index]

  def index
    respond_with @plans = current_user.plans
  end

  def destroy
    respond_with @plan.destroy
  end
end
