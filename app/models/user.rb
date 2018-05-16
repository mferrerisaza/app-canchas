class User < ApplicationRecord
  has_many :booking_players, dependent: :nullify
  has_many :businesses, dependent: :destroy
  has_many :bookings, through: :booking_players
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :photo, PhotoUploader
  colombian_id_regex = /\A((\d{8})|(\d{10})|(\d{11})|(\d{6}-\d{5}))\z/
  phone_regex = /\A(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$\z/

  validates :first_name, :last_name, presence: true, on: :update
  validates :identificacion, format:
  {
    with: colombian_id_regex,
    message: "por favor ingrese un número de identificación válido, recuerde que no utilizar caracteres especiales (como espacios, *, -)",
    allow_blank: false
  }, on: :update
  validates :telefono, format:
  {
    with: phone_regex,
    message: "por favor ingrese un teléfono o celular válido",
    allow_blank: false
  }, on: :update

  devise :omniauthable, omniauth_providers: [:facebook]
  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:remote_photo_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiracy] = Time.zone.at(auth.credentials.expires_at)
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
end
