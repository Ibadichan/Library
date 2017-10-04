class Authorization < ApplicationRecord
  belongs_to :user

  validates_presence_of :uid, :provider, presence: true
end
