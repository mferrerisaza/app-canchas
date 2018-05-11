class Business < ApplicationRecord
  scope :by_longitude, -> (min, max) { min && max ? where('longitude >= :min AND longitude <= :max', min: min, max: max) : all }
  scope :by_latitude, -> (min, max) { min && max ? where('latitude >= :min AND latitude <= :max', min: min, max: max) : all }
  STARS = [1, 2, 3, 4, 5].freeze
  API_RESULTS_LIMIT = 100

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

  def self.search(min_lat, max_lat, min_lng, max_lng)
    by_latitude(min_lat, max_lat).
      by_longitude(min_lng, max_lng).
      limit(API_RESULTS_LIMIT)
  end
end
