class BookingPlayer < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  monetize :price_cents

  validates :booking, :user, presence: true
  validate :check_user_info, on: %i[create update]


  def check_user_info
    error_text = 'User must have phone and colombian_id to be part of a booking'
    if user.telefono.nil? && user.identificación.nil?
      errors.messages[:booking_player] << error_text
      false
    else
      true
    end
  end

end
