class User < ApplicationRecord
  TEMP_EMAIL_REGEX = /\Achange@me/
  has_many :authorizations, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[facebook twitter vkontakte]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info.email

    user = User.where(email: email).first

    unless user
      user = User.new(email: email ? email : "change@me-#{auth.uid}-#{auth.provider}.com",
                      password: Devise.friendly_token[0, 20])
      user.skip_confirmation!
      user.save!
    end

    user.authorizations.create!(provider: auth.provider, uid: auth.uid.to_s)
    user
  end

  def email_verified?
    email && email !~ TEMP_EMAIL_REGEX
  end
end
