class UsersController < ApplicationController
  # skip_after_action :verify_authorized
  before_action :set_booking, :set_user

  def edit
    authorize @booking
    unless @user.first_name.blank? || @user.telefono.blank? || @user.identificacion.blank?
      @booking.booking_players << BookingPlayer.new(user: @user) if @booking.users.size.zero?
      redirect_to bookings_path
    end
  end

  def update
    @user.update(user_params)
    authorize @booking
    if @user.save
      @booking.booking_players << BookingPlayer.new(user: @user) if @booking.users.size.zero?
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

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :telefono,
                                 :identificacion)
  end
end
