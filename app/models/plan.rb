class Plan < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per 2

  belongs_to :user

  has_many :plans_books, dependent: :destroy
  has_many :books, through: :plans_books

  validates :title, :slug, :description, presence: true

  def percent_of_readed_books
    one_percent = books.size / 100.0
    size_of_marked_books / one_percent
  end

  def update_marked_field_for(book)
    plans_books.find_by_book_id(book.id).update(marked: true) if book
  end

  def make_clone_by(user)
    copy_of_plan = dup
    copy_of_plan.user = user
    copy_of_plan.books = books
    copy_of_plan.save
    copy_of_plan
  end

  def size_of_marked_books
    plans_books.where(marked: true).size.to_f
  end
end
