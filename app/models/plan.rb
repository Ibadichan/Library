class Plan < ApplicationRecord
  belongs_to :user

  has_many :plans_books, dependent: :destroy
  has_many :books, through: :plans_books

  validates :title, :description, presence: true

  def percent_of_readed_books
    one_percent = books.size / 100.0
    marked_books = books.where(marked: true).size.to_f
    marked_books / one_percent
  end
end
