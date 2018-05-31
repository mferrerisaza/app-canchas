class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = 'No esta autorizado para realizar esta acción'
    redirect_to(root_path)
  end

  def after_sign_in_path_for(resource)
    if session[:booking].present?
      edit_user_path(current_user)
    else
      super
    end
  end

  def create_booking_after_update_user_info(user)
    @booking = Booking.new(session[:booking])
    @booking.status = 'Pendiente'
    session[:booking] = nil
    if @booking.save
      append_booking_player(user)
      bookings_path
      flash[:notice] = 'Tu solicitud se ha registrado con éxito. En breve te contactaremos'
    else
      flash[:notice] = 'Se ha actualizado la información exitosamente'
    end
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

  private

  def append_booking_player(user)
    return unless @booking.users.size.zero?
    @booking.booking_players << BookingPlayer.new(user: user)
    BookingMailer.send_request(@booking, user)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
