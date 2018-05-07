class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]
  after_action :verify_authorized, except: [:create]
  before_action :set_booking, only: [ :show ]

  def create
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
     params.permit(:field_id, :date, :splitable)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end


end

