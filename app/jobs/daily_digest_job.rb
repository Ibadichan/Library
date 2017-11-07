class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each.each do |user|
      next unless user.subscriptions.present?
      user.subscriptions.each do |subscription|
        if subscription.plans_book.marked?
          subscription.destroy
          next
        end
        DailyMailer.digest(user, subscription).deliver_later
      end
    end
  end
end
