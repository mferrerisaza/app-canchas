class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
    if @user.save
      create_booking_after_update_user_info(@user)
      redirect_to bookings_path
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :telefono,
                                 :identificacion)
  end

  def user_info_exists?(array)
    array.any? { |field| @user.send(field).blank? }
  end
end
