module BookingHelper
  def booking_status_text(booking)
    if booking.date < Time.zone.now && booking.status == 'Pendiente'
      'No confirmada'
    else
      booking.status
    end
  end
end
