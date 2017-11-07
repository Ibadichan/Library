class DailyMailer < ApplicationMailer
  def digest(user, subscription)
    @book = Search.find_book(subscription.plans_book.book.google_book_id)

    mail to: user.email, subject: 'Daily Digest'
  end
end
