class User < ApplicationRecord
  has_many :booking_players, dependent: :nullify
  has_many :businesses, dependent: :destroy
  has_many :bookings, through: :booking_players
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :photo, PhotoUploader
  after_create :send_verification_email

  devise :omniauthable, omniauth_providers: [:facebook]
  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:photo] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.zone.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email)
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20]
      user.save
    end

    user
  end

  private

  def send_welcome_email
    UserMailer.verification(self).deliver_now
  end

end
