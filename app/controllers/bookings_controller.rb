class BookingsController < ApplicationController
  before_action :set_booking, only: [ :show ]

  def create
    byebug
    @booking = Booking.new(booking_params)
    authorize @booking
    if @booking.save
      render :show
    else
      redirect_to fields_path
    end
  end

  def show
    authorize @booking
  end

  private

  def booking_params
     params.permit(:field_id, :date, :splitable, :number_players)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end


end

