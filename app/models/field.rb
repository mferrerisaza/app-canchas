class Field < ApplicationRecord
  include PgSearch

  CAPACITY_RANGE = (2..24).to_a
  belongs_to :business
  has_many :bookings

  monetize :price_cents

  validates :name, :business, :capacity, :price,  presence: true
  validates :capacity, inclusion: { in: CAPACITY_RANGE }
  validates :price, numericality: { greater_than: 0 }

  mount_uploader :photo, PhotoUploader

  pg_search_scope :search_by_attributes,
    against: :capacity,
    associated_against: {
      business: [ :name, :address ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
