class BookingsController < ApplicationController
  after_action :verify_authorized, except: :create
  before_action :authenticate_user!, except: :create
  before_action :set_booking, only: [:show]

  def create
    if current_user.nil?
      session[:booking] = booking_params
      redirect_to new_user_registration_path
    else
      @booking = Booking.new(booking_params)
      @booking.booking_players << BookingPlayer.new(user: current_user)
      check_if_save
    end
  end

  def show
    authorize @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:field_id,
                                    :date,
                                    :splitable,
                                    :number_players)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def check_if_save
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to fields_path
    end
  end
end
