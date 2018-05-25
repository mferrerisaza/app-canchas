class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.verification.subject
  #
  def self.send_request(booking, user)
    team_emails = ['noreply@scuad.co']
    team_emails.each do |email|
      booking_request(email, booking, user).deliver_now
    end
  end

  def booking_request(email, booking, user)
    @booking = booking
    @user = user
    mail(to: email,
         subject: "Solicitud de reserva. Reserva N°#{Booking.all.size}")
  end
end
