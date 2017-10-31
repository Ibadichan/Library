class Plan < ApplicationRecord
  belongs_to :user

  has_many :plans_books, dependent: :destroy
  has_many :books, through: :plans_books

  validates :title, :description, presence: true

  def percent_of_readed_books
    one_percent = books.size / 100.0
    marked_books = plans_books.where(marked: true).size.to_f
    marked_books / one_percent
  end

  def update_marked_field_for(book)
    plans_books.find_by_book_id(book.id).update(marked: true) if book
  end
end
