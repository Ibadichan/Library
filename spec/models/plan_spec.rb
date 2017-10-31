require 'rails_helper'

RSpec.describe Plan, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:user) }

  it { should have_many(:plans_books).dependent(:destroy) }
  it { should have_many(:books).through(:plans_books) }

  describe '#percent_of_readed_books' do
    let(:plan)        { create(:plan) }
    let(:left_books)  { create_list(:book, 3) }
    let(:readed_book) { create(:book) }

    it 'returns percent of readed books' do
      plan.books << readed_book << left_books
      plan.plans_books.first.update(marked: true)
      expect(plan.percent_of_readed_books).to eq 25
    end
  end

  describe '#update_marked_field_for' do
    let(:plan) { create(:plan) }
    let(:book) { create(:book) }

    before { plan.books << book }

    it 'changes value of plan_book to true' do
      plan.update_marked_field_for(book)
      expect(plan.plans_books.first.marked).to eq true
    end
  end
end
