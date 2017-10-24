require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'For guest' do
    let(:user) { nil }

    # it { should be_able_to :read, :all  }
    it { should_not be_able_to :manage, :all }
  end

  describe 'For admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'For user' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

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

    before { user.books << book }

    it { should_not be_able_to :add_in_favorites, book, user: user }
    it { should be_able_to :destroy, book, user: user }
  end
end
