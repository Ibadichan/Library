class Plan < ApplicationRecord
  belongs_to :user

  has_many :plans_books, dependent: :destroy
  has_many :books, through: :plans_books

  validates :title, presence: true
end
