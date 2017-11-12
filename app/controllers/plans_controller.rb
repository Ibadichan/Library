class PlansController < ApplicationController
  load_and_authorize_resource except: %i[index]
  skip_authorization_check only: %i[index]

  def index
    respond_with @plans = current_user.plans
  end

  def show
    @books = @plan.books.page params[:page]
    respond_with @plan
  end

  def new; end

  def create
    respond_with @plan = current_user.plans.create(plan_params), location: -> { [current_user, @plan] }
  end

  def edit; end

  def update
    @plan.update(plan_params)
    respond_with @plan, location: -> { [current_user, @plan] }
  end

  def destroy
    respond_with @plan.destroy
  end

  def share
    respond_with @plan.update(public: true)
  end

  def make_private
    respond_with @plan.update(public: false)
  end

  def take
    copy_of_plan = @plan.dup
    copy_of_plan.user = current_user
    copy_of_plan.books = @plan.books
    copy_of_plan.save
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :description, book_ids: [])
  end
end
