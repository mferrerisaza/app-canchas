class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.verification.subject
  #
  def self.booking_request(booking, user)
    team_emails = ['dlopez.10g@gmail.com', 'dlopezg3@eafit.edu.co']
    team_emails.each do |email|
      send_request(email, booking, user).deliver_now
    end
  end

  def send_request(email, booking, user)
    @booking = booking
    @user = user

    mail(to: email,
         subject: "Solicitud de reserva. Reserva N°#{Booking.all.size}")
  end
end
