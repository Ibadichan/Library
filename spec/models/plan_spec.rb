require 'rails_helper'

RSpec.describe Plan, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:user) }

  it { should have_many(:plans_books).dependent(:destroy) }
  it { should have_many(:books).through(:plans_books) }

  describe '#percent_of_readed_books' do
    let(:plan) { create(:plan) }
    let(:readed_book) { create(:book, marked: true) }
    let(:left_books) { create_list(:book, 3, marked: false) }

    it 'returns percent of readed books' do
      plan.books << readed_book << left_books
      expect(plan.percent_of_readed_books).to eq 25
    end
  end
end
