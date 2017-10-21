require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:authorizations).dependent(:destroy) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :avatar }
  it { should have_many(:users_books).dependent(:destroy) }
  it { should have_many(:books).through(:users_books) }

  describe '#email_verified?' do
    let(:user)      { create(:user) }
    let(:fake_user) { create(:user, email: 'change@me') }

    context 'email is not verified' do
      it('returns true') { expect(user.email_verified?).to eq true }
    end

    context 'email is verified' do
      it('returns false') { expect(fake_user.email_verified?).to eq false }
    end
  end

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
        context 'Email is given' do
          let(:auth) do
            OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                   info: { email: 'new@mail.com', name: 'Ivan',
                                           image: 'http://via.placeholder.com/350x150' })
          end

          it 'creates a new user' do
            expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
            user = User.find_for_oauth(auth)
            expect(user.email).to eq auth.info.email
            expect(user.name).to eq auth.info.name
            expect(user.avatar).to_not be_nil
          end

          RSpec.shared_examples 'the create authorization and return user' do
            it 'creates a new authorization for user with provider and uid' do
              expect { User.find_for_oauth(auth) }.to change(Authorization, :count).by(1)
              authorization = User.find_for_oauth(auth).authorizations.first
              expect(authorization.provider).to eq auth.provider
              expect(authorization.uid).to eq auth.uid
            end

            it 'finds and returns user' do
              expect(User.find_for_oauth(auth)).to be_a(User)
            end
          end

          it_behaves_like 'the create authorization and return user'
        end

        context 'Email is not given' do
          let(:auth) do
            OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                   info: { name: 'Ivan',
                                           image: 'http://via.placeholder.com/350x150' })
          end

          it 'creates a new user with fake email' do
            expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
            user = User.find_for_oauth(auth)
            expect(user.email).to eq "change@me-#{auth.uid}-#{auth.provider}.com"
            expect(user.name).to eq auth.info.name
            expect(user.avatar).to_not be_nil
          end

          it_behaves_like 'the create authorization and return user'
        end
      end
    end
  end
end
