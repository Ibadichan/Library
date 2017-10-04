require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:authorizations).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }

    context 'User has authorization' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

      it 'returns user' do
        user.authorizations.create(provider: auth.provider, uid: auth.uid)
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    describe 'User has not authorization' do
      context 'User exists' do
        let(:auth) do
          OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email })
        end

        it 'creates a new authorization for user with provider and uid' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
          expect(user.authorizations.first.provider).to eq auth.provider
          expect(user.authorizations.first.uid).to eq auth.uid
        end

        it 'does not create a new User' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'finds and returns user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'User does not exist' do
        let(:auth) do
          OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                 info: { email: 'new@mail.com' })
        end

        it 'creates a new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
          expect(User.find_for_oauth(auth).email).to eq auth.info.email
        end

        it 'creates a new authorization for user with email' do
          expect { User.find_for_oauth(auth) }.to change(Authorization, :count).by(1)
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'finds and returns user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
      end
    end
  end
end
