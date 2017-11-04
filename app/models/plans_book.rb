class PlansBook < ApplicationRecord
  belongs_to :book
  belongs_to :plan
  has_many :subscriptions, dependent: :destroy
end
