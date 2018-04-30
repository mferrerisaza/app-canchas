class BusinessesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def show
    authorized @business
  end

  def index
    @businesses = policy_scope(Business)
  end

  def new
    authorized @business
  end

  def create
    authorized @business
  end
end
