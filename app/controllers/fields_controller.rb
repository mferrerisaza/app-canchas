class FieldsController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show, :test]
after_action :verify_authorized, except: [:index, :test]

  def index
    @businesses = policy_scope(Business.where.not(latitude: nil, longitude: nil))
    @fields = Field.all.decorate #FieldDecorator.decorate_collection(Field.all.select { |field| @businesses.include?(field.business) })
    # @schedule = build_schedule_filtered

    @markers = @businesses.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def show
  end

  def new
    authorize @field
  end

  def create
    authorize @field
  end

  def schedule
    dates = params[:dates].split("to").map { |date| Date.parse(date) }
    start_hour = params[:start_time].to_i
    end_hour = params[:end_time].to_i
    time_range = (start_hour..end_hour)
    @schedule = Booking.build_schedule(dates)
    @schedule.each_key do |date_key|
      @schedule[date_key].each_key do |field_key|
        @schedule[date_key][field_key].keep_if { |k,v| v == 0 && time_range.include?(k.to_i) }
      end
    end
    render json: @schedule
  end

  def build_schedule_filtered
    dates = params[:dates].split("to").map { |date| Date.parse(date) }
    start_hour = params[:start_time].to_i
    end_hour = params[:end_time].to_i
    @schedule = Booking.build_schedule(dates)
  end
end
