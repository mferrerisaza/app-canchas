class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = 'You are not authorized to perform this action.'
  #   redirect_to(root_path)
  # end

  def after_sign_in_path_for(resource)
    if session[:booking].present?
      @booking = Booking.create(session[:booking])
      BookingMailer.booking_request(@booking, current_user)
      session[:booking] = nil
      @booking.booking_players << BookingPlayer.new(user: current_user)
      flash[:notice] = 'Has iniciado sesión con éxito y
                        tu reserva se ha registrado'
      booking_path(@booking)
    else
      super
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
