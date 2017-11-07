require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:users) { create_list(:user, 2) }
  let(:plan)  { create(:plan, user: users.first) }
  let(:book)  { create(:book) }

  let(:subscriber) { users.first }

  before do
    subscriber.books << book
    plan.books << book
    subscriber.subscriptions.create(plans_book: plan.plans_books.first)
  end

  it 'sends daily digest to subscribers' do
    expect(DailyMailer)
      .to receive(:digest).with(subscriber, subscriber.subscriptions.first).and_call_original
    DailyDigestJob.perform_now
  end
end
