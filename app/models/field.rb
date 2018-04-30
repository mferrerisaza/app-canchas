class Field < ApplicationRecord
  CAPACITY_RANGE = 2..24
  belongs_to :business
  has_many :bookings

  monetize :price_cents

  validates :name, :business, :capacity, :price,  presence: true
  validates :capacity, inclusion: { in: CAPACITY_RANGE }
  validates :price, numericality: { greater_than: 0 }

  mount_uploader :photo, PhotoUploader

end
