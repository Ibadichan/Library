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

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :read, user, user: user }
    it { should_not be_able_to :read, create(:user), user: user }

    it { should be_able_to :finish_sign_up, user, user: user }
    it { should_not be_able_to :finish_sign_up, create(:user), user: user }
  end
end
