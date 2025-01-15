module Crud
  extend ActiveSupport::Concern

  included do
    attr_accessor :model, :model_lowercase
  end

  def index
    render json: model.where(user: @current_user)
  end

  def show
    object_json = model.where(user: @current_user, id: params[:id])
    if object_json.empty?
      render status: :not_found
    else
      render json: object_json.first
    end
  end

  def create
    params[@model_name][:user_id] = @current_user.id
    model = @model.new(model_params)
    if model.save
      render json: model, status: :created
    else
      render :new, status: :unprocessable_entity, json: model.errors
    end
  rescue ActionController::ParameterMissing
    render status: :bad_request, json: model.errors
  end

  def update
    model_object = model.where(user: @current_user, id: params[:id])
    if model_object.empty?
      render status: :not_found
      return
    end

    model = model_object.first
    if model.update model_params
      render json: model
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing
    render status: :bad_request, json: model.errors
  end

  private
  def model_params(ommit = [])
    if !ommit.empty?

    end
    fields = @model.attribute_names.map { |attr| attr.to_sym }
    params.expect(Hash[@model_name, fields])
  end
end
