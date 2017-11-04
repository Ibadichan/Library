class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plans_book
end
