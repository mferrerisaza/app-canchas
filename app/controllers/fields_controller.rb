class FieldsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show schedule]
  after_action :verify_authorized, except: %i[index show schedule]

  def index
    set_businesses
    set_schedule
    set_fields
    set_dates
    set_markers
  end

  def show
    @field = Field.find(params[:id])
    render json: @field, include:
      [
        business:
        {
          only: %i[name address phone rating latitude longitude photo]
        }
      ]
  end

  def new
    authorize @field
  end

  def create
    authorize @field
  end

  def schedule
    @schedule = Booking.build_schedule(filtering_params)
    render json: @schedule
  end

  private

  def filtering_params
    params.slice(:dates, :start_time, :end_time, :capacity_limit, :query)
  end

  def set_businesses
    @businesses = policy_scope(Business.where.not(latitude: nil,
                                                  longitude: nil))
  end

  def set_schedule
    @schedule = Booking.build_schedule(filtering_params)
  end

  def set_fields
    @fields = @schedule.first[1].keys.map { |field_id| Field.find(field_id) }
  end

  def set_dates
    date_array = ApplicationController.helpers.extract_date(filtering_params)
    @date_range = date_array[0]..date_array[1]
  end

  def set_markers
    @markers = @businesses.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box",
        # locals: { flat: flat }) }
      }
    end
  end
end
