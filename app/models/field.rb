class Field < ApplicationRecord
  include PgSearch
  scope :capacity_limit, -> (capacity) { where("capacity = ?", capacity) }

  CAPACITY_RANGE = (8..24).step(2).to_a
  belongs_to :business
  has_many :bookings

  monetize :price_cents

  validates :name, :business, :capacity, :price,  presence: true
  validates :capacity, inclusion: { in: CAPACITY_RANGE }
  validates :price, numericality: { greater_than: 0 }

  mount_uploader :photo, PhotoUploader

  pg_search_scope :query,
    associated_against: {
      business: [ :name, :address ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def self.retrive_filtered_fields(args = {})
    fields = self.where(nil)
    fields = fields.capacity_limit(args[:capacity_limit]) if args[:capacity_limit].present?
    fields = fields.query(args[:query]) if args[:query].present?
    return fields
  end
end
