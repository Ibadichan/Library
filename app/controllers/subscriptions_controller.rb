class SubscriptionsController < ApplicationController
  before_action :set_plans_book

  def create
    authorize! :subscribe, @plans_book
    respond_with @subscription = current_user.subscriptions.create(plans_book: @plans_book)
  end

  def destroy
    authorize! :unsubscribe, @plans_book
    respond_with Subscription.find(params[:id]).destroy
  end

  private

  def set_plans_book
    @plans_book = PlansBook.where(book_id: params[:book_id], plan_id: params[:plan_id]).first
  end
end
