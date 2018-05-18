class Field < ApplicationRecord
  include PgSearch
  scope :capacity_limit, ->(capacity) { where('capacity = ?', capacity) }

  CAPACITY_RANGE = (8..24).step(2).to_a
  belongs_to :business
  has_many :bookings, dependent: :nullify

  monetize :price_cents

  validates :name, :business, :capacity, :price, presence: true
  validates :capacity, inclusion: { in: CAPACITY_RANGE }
  validates :price, numericality: { greater_than: 0 }

  mount_uploader :photo, PhotoUploader

  pg_search_scope :query, associated_against:
  { business: %i[name address] }, using: { tsearch: { prefix: true } }

  def self.retrive_filtered_fields(args = {})
    fields = where(nil)
    if args[:capacity_limit].present?
      fields = fields.capacity_limit(args[:capacity_limit])
    end
    if args[:query].present?
      # fields = fields.query(args[:query])
      results = Geocoder.search(args[:query])
      unless results.blank?
        args[:min_lat] ||= results[0].geometry["viewport"]["southwest"]["lat"]
        args[:max_lat] ||= results[0].geometry["viewport"]["northeast"]["lat"]
        args[:min_lng] ||= results[0].geometry["viewport"]["southwest"]["lng"]
        args[:max_lng] ||= results[0].geometry["viewport"]["northeast"]["lng"]
      end
    end
    symbol_array = %i[min_lng max_lng min_lat max_lat]
    if symbol_array.all? { |arg| args[arg].present? }
      fields = fields.where(business: Business.search(args[:min_lat].to_f, args[:max_lat].to_f, args[:min_lng].to_f, args[:max_lng].to_f))
    end
    fields
  end
end
