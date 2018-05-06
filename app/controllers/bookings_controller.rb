class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]
  skip_before_action :verify_authenticity_token

  def create
    byebug
    @booking = Booking.new (booking_params)
  end

  def show
  end

  private

    def booking_params
     params.require(:booking).permit(:field_id, :date, :splitable)
    end

end

