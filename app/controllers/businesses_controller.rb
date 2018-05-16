class BusinessesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def show
    authorize @business
  end

  def index
    @businesses = policy_scope(Business)
  end

  def new
    authorize @business
  end

  def create
    authorize @business
  end
end
