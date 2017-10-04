class User < ApplicationRecord
  has_many :authorizations, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info.email
    password = Devise.friendly_token[0, 20]

    user = User.where(email: email).first
    user ||= User.new(email: email, password: password, password_confirmation: password)
    user.skip_confirmation!
    user.save!

    user.authorizations.create!(provider: auth.provider, uid: auth.uid.to_s)
    user
  end
end
