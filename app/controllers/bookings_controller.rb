class BookingsController < ApplicationController
  after_action :verify_authorized, except: %i[index create]
  before_action :authenticate_user!, except: :create

  def index
    @bookings = policy_scope(Booking)
  end

  def create
    session[:booking] = booking_params
    if current_user.nil?
      redirect_to new_user_session_path
    else
      @booking = Booking.new(booking_params)
      check_if_save
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update(booking_status)

    if @booking.save
      redirect_to bookings_path
      BookingMailer.booking_status_change(@booking).deliver_now
    else
      render 'edit'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:field_id,
                                    :date,
                                    :splitable,
                                    :number_players)
  end

  def booking_status
    params.require(:booking).permit(:status)
  end

  def check_if_save
    if @booking.valid?
      redirect_to edit_user_path(current_user)
    else
      redirect_to fields_path
      flash[:alert] = 'No hemos podido registrar tu reserva. Porfavor intenta nuevamente'
    end
  end
end
