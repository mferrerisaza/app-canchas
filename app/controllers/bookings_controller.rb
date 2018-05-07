class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]
  skip_before_action :verify_authenticity_token
  after_action :verify_authorized, except: [:create]

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
    @booking = Booking.find(params[:field_id])
  end

  private

    def booking_params
     params.permit(:field_id, :date, :splitable)
    end

end

