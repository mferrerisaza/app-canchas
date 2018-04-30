class BookingPlayer < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  monetize :price_cents

  validates :booking, :user, presence: true
end
