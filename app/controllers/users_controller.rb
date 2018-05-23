class UsersController < ApplicationController
  after_action :verify_authorized, except: %i[edit update]
  before_action :authenticate_user!
  before_action :set_user

  def edit
    non_blank_fields = %w[first_name last_name telefono identificacion]
    return if non_blank_fields.any? { |field| @user.send(field).blank? }
  end

  def update
    @user.update(user_params)
    if @user.save
      create_booking_after_sign_in(@user)
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
end
