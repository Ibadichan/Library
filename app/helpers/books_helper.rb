module BooksHelper
  def search_book(book)
    response = Search.find_book(book.google_book_id)
    info = response['items'][0]['volumeInfo']

    title = info['title'] if info['title']
    published_at = "published_at: #{info['publishedDate']}" if info['publishedDate']
    authors = "authors: #{info['authors'].join(',')}" if info['authors']

    "#{title}, #{published_at}, #{authors}"
  end
end
