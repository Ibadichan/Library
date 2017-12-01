require 'rails_helper'

RSpec.describe DailyMailer, type: :mailer do
  describe 'digest' do
    let(:user) { create(:user) }
    let(:book) { create(:book, google_book_id: 'T2-ExG-f1TkC') }
    let(:plan) { create(:plan, user: user) }
    let(:mail) { DailyMailer.digest(user, user.subscriptions.first) }

    before do
      user.books << book
      plan.books << book
      user.subscriptions.create(plans_book: book.plans_books.first)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq 'Daily Digest'
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ['badican01117@gmail.com']
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match 'Stalin'
      expect(mail.body.encoded).to match 'Drawing on a wealth of unexplored material'
      expect(mail.body.encoded).to match 'Robert Service'
    end
  end
end
