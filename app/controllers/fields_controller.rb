class FieldsController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]


  def index
    @businesses = policy_scope(Business.where.not(latitude: nil, longitude: nil))
    @fields = Field.all.select { |field| @businesses.include? (field.business) }

    @markers = @fields.map do |field|
      {
        lat: field.business.latitude,
        lng: field.business.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def show
  end

  def new
    authorized @field
  end

  def create
    authorized @field
  end
end
