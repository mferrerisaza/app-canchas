class FieldDecorator < Draper::Decorator
  delegate_all

  def field_available_hours
    booked_hours = []
    available_hours = []
    Booking.where(field_id: field.id).each { |booking| booked_hours << booking.date.hour }
    horas = (17..24).to_a # son solo esas para que no aparezca todo en el view (y se crea así pq no tenemos tabla de fechas)
    horas.each { |hora| available_hours << hora unless booked_hours.include?(hora) }
    return available_hours
  end


end
