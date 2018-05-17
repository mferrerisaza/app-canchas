class UsersController < ApplicationController
  # skip_after_action :verify_authorized
  before_action :set_booking, :set_user

  def edit
    authorize @booking
    non_blank_fields = %w[first_name last_name telefono identificacion]
    return if non_blank_fields.any? { |field| @user.send(field).blank? }
    append_booking_player(@booking, @user)
    redirect_to bookings_path
  end

  def update
    @user.update(user_params)
    authorize @booking
    if @user.save
      append_booking_player(@booking, @user)
      redirect_to bookings_path
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def append_booking_player(booking, user)
    return unless booking.users.size.zero?
    booking.booking_players << BookingPlayer.new(user: user)
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :telefono,
                                 :identificacion)
  end
end
