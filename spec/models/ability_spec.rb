require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'For guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
  end

  describe 'For admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'For user' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:plan) { create(:plan, user: user) }

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :read, user, user: user }
    it { should_not be_able_to :read, create(:user), user: user }

    it { should be_able_to :finish_sign_up, user, user: user }
    it { should_not be_able_to :finish_sign_up, create(:user), user: user }

    it { should be_able_to :add_in_favorites, create(:book), user: user }
    it { should_not be_able_to :destroy, create(:book), user: user }

    it { should be_able_to :destroy, create(:plan, user: user), user: user }
    it { should_not be_able_to :destroy, create(:plan), user: user }

    it { should be_able_to :read, create(:plan, user: user), user: user }
    it { should_not be_able_to :read, create(:plan), user: user }

    it { should be_able_to :create, Plan }

    it { should be_able_to :update, create(:plan, user: user), user: user }
    it { should_not be_able_to :update, create(:plan), user: user }

    it { should_not be_able_to :subscribe, create(:book).plans_books.first, user: user }
    it { should_not be_able_to :unsubscribe, create(:book).plans_books.first, user: user }

    it { should be_able_to :share, create(:plan, public: false, user: user), user: user }
    it { should_not be_able_to :share, create(:plan, public: true, user: user), user: user }
    it { should_not be_able_to :share, create(:plan), user: user }

    it { should be_able_to :make_private, create(:plan, public: true, user: user), user: user }
    it { should_not be_able_to :make_private, create(:plan, public: false, user: user), user: user }
    it { should_not be_able_to :make_private, create(:plan), user: user }

    it { should be_able_to :search_others_users, User }

    before do
      user.books << book
      plan.books << book
    end

    it { should_not be_able_to :add_in_favorites, book, user: user }
    it { should be_able_to :destroy, book, user: user }
    it { should be_able_to :subscribe, book.plans_books.first, user: user }
    it { should_not be_able_to :unsubscribe, book.plans_books.first, user: user }

    it do
      book.plans_books.first.update(marked: true)
      should_not be_able_to :subscribe, book.plans_books.first, user: user
    end

    it do
      book.plans_books.first.update(marked: true)
      should_not be_able_to :unsubscribe, book.plans_books.first, user: user
    end

    it do
      book.plans_books.first.subscriptions.create(user: user)
      should_not be_able_to :subscribe, book.plans_books.first, user: user
    end

    it do
      book.plans_books.first.subscriptions.create(user: user)
      should be_able_to :unsubscribe, book.plans_books.first, user: user
    end
  end
end
