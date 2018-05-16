class BookingsController < ApplicationController
  after_action :verify_authorized, except: %i[index create]
  before_action :authenticate_user!, except: :create

  def index
    @bookings = policy_scope(
      Booking.joins(:users).where(users: { id: current_user.id })
    )
  end

  def create
    if current_user.nil?
      session[:booking] = booking_params
      redirect_to new_user_session_path
    else
      @booking = Booking.new(booking_params)
      check_if_save
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:field_id,
                                    :date,
                                    :splitable,
                                    :number_players)
  end

  def check_if_save
    if @booking.save
      BookingMailer.send_request(@booking, current_user)
      redirect_to edit_booking_user_path(@booking, current_user)
    else
      redirect_to fields_path
    end
  end
end
