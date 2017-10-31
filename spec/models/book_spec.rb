require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :google_book_id }
  it { should validate_uniqueness_of :google_book_id }

  it { should have_many(:users_books).dependent(:destroy) }
  it { should have_many(:readers).source(:user).through(:users_books) }

  it { should have_many(:plans_books).dependent(:destroy) }
  it { should have_many(:plans).through(:plans_books) }

  describe '#readed_in?' do
    let(:book) { create(:book) }
    let(:plan) { create(:plan) }

    before { plan.books << book }

    context 'book is readed' do
      it 'returns true' do
        plan.plans_books.first.update(marked: true)
        expect(book.readed_in?(plan)).to eq true
      end
    end

    context 'book is not readed' do
      it 'returns false' do
        plan.plans_books.first.update(marked: false)
        expect(book.readed_in?(plan)).to eq false
      end
    end
  end
end
