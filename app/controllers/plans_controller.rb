class PlansController < ApplicationController
  load_and_authorize_resource except: %i[index]
  skip_authorization_check only: %i[index]

  def index
    respond_with @plans = current_user.plans
  end

  def show; end

  def new; end

  def create
    respond_with @plan = current_user.plans.create(plan_params), location: -> { [current_user, @plan] }
  end

  def destroy
    respond_with @plan.destroy
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :description, book_ids: [])
  end
end
