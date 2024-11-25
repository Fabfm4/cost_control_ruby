module Crud
  extend ActiveSupport::Concern

  included do
    attr_accessor :model, :model_lowercase
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
    model = @model.new(model_params)
    if model.save
      render json: model, status: :created
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => error
    render json: { error: error.message }, status: :bad_request
  end

  def update
    model = @model.find(params[:id])
    if model.update model_params
      render json: model
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
  def model_params(ommit = [])
    if !ommit.empty?

    end
    fields = @model.attribute_names.map { |attr| attr.to_sym }
    puts Hash[@model_name, fields], fields
    params.expect(Hash[@model_name, fields])
  end
end
