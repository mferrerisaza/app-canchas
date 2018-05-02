class FieldsController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show, :schedule]
after_action :verify_authorized, except: [:index, :show, :schedule]

  def index
    @businesses = policy_scope(Business.where.not(latitude: nil, longitude: nil))
    @schedule = Booking.build_schedule(filtering_params)
    @fields = Field.retrive_filtered_fields(filtering_params) #.decorate #FieldDecorator.decorate_collection(Field.all.select { |field| @businesses.include?(field.business) })

    @markers = @businesses.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def show
     @field = Field.find(params[:id])
     render json: @field
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
end
