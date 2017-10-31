class Book < ApplicationRecord
  paginates_per 3

  has_many :users_books, dependent: :destroy
  has_many :readers, through: :users_books, source: :user

  has_many :plans_books, dependent: :destroy
  has_many :plans, through: :plans_books

  validates :google_book_id, presence: true, uniqueness: true

  def readed_in?(plan)
    plans_books.find_by_plan_id(plan.id).try(:marked?)
  end
end
