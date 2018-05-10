class Business < ApplicationRecord
  STARS = [1, 2, 3, 4, 5].freeze

  belongs_to :user
  has_many :fields, dependent: :destroy

  validates :name, :address, presence: true
  validates :rating, inclusion: { in: STARS }

  mount_uploader :photo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def opening_hours
    (opening..closing)
  end
end
