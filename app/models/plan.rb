class Plan < ApplicationRecord
  belongs_to :user

  has_many :plans_books, dependent: :destroy
  has_many :books, through: :plans_books

  validates :title, :description, presence: true
end
