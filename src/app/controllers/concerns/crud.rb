module Crud
  extend ActiveSupport::Concern

  included do
    attr_accessor :model
  end

  def index
    render json: model.all
  end

  def show
    render json: model.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  end

  def create
    @model = model.new(model_params)
    if @model.save
      render json: @model, status: :created
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => error
    render json: { error: error.message }, status: :bad_request
  end

  def update
    @model = model.find(params[:id])
    if @model.update model_params([ :id, :created_at, :updated_at ])
      render json: @model
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  rescue ActionController::ParameterMissing => error
    puts error
    render json: { error: error.message }, status: :bad_request
  end

  private
  def model_params
    fields = model.attribute_names.map { |attr| attr.to_sym }
    params.expect(Hash[model.name.downcase, fields])
  end
end
