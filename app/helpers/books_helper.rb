module BooksHelper
  def search_book(book)
    response = Search.find_book(book.google_book_id)
    info = response['items'][0]['volumeInfo']

    title = info['title'] if info['title']
    published_at = "published_at: #{info['publishedDate']}" if info['publishedDate']
    authors = "authors: #{info['authors'].join(',')}" if info['authors']

    "#{title}, #{published_at}, #{authors}"
  end

  def find_subscription_by(user, plan, book)
    plans_book = plan.plans_books.find_by(book_id: book.id)
    user.subscriptions.find_by(plans_book: plans_book)
  end
end
