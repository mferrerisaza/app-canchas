class FieldsController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]


  def index
    @fields = policy_scope(Field)
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
