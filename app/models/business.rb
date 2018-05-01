class Business < ApplicationRecord
  STARS = [1, 2, 3, 4, 5]

  belongs_to :user
  has_many :fields


  validates :name, :address, presence: true
  validates :rating, inclusion: { in: STARS }

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end
