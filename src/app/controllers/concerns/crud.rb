module Crud
  extend ActiveSupport::Concern

  included do
    attr_accessor :model, :model_lowercase
  end

  def index
    if @has_user
      render json: model.where(user: @current_user)
      return
    end
    render json: model.all
  end

  def show
    render json: model.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  end

  def create
    if @has_user
      params[@model_name][:user_id] = @current_user.id
    end
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
    model = @model.find(params[:id])
    if model.update model_params
      render json: model
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  rescue ActionController::ParameterMissing
    render status: :bad_request, json: model.errors
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
