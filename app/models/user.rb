class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,
         :omniauth_providers => [:twitter, :facebook, :linkedin, :google_oauth2, *(:developer if Rails.env.development?)]

         #It will add user to database for Sign In using social Media
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = SecureRandom.base64(15)
    end
  end
end
