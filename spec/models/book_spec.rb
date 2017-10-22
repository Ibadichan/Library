require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :google_book_id }
  it { should validate_uniqueness_of :google_book_id }

  it { should have_many(:users_books).dependent(:destroy) }
  it { should have_many(:readers).source(:user).through(:users_books) }

  it { should have_many(:plans_books).dependent(:destroy) }
  it { should have_many(:plans).through(:plans_books) }
end
