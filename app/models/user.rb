class User < ApplicationRecord
  has_many :booking_players
  has_many :businesses
  has_many :bookings, through: :booking_players
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :photo, PhotoUploader
end
