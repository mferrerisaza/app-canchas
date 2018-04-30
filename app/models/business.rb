class Business < ApplicationRecord
  STARS = [1, 2, 3, 4, 5]

  belongs_to :user
  has_many :fields

  mount_uploader :photo, PhotoUploader

  validates :name, :address, presence: true
  validates :rating, inclusion: { in: STARS }
end
