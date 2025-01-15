class BanksController < ApplicationController
  include Mixin

  def initialize
    @model_name = "bank"
    super
  end

  before_action :authorize_request
  before_action :add_user_id_to_params, only: [ :create, :update ]
  after_action :paginate, only: [ :index ]

  def index
    render json: Bank.get_bank_list_by_user(@current_user)
  end

  def show
    render json: Bank.get_bank_retrieve_by_id(params[:id], @current_user)
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  end

  def create
    new_record = Bank.create_bank(model_params(Bank, "bank"))
    if new_record.errors.empty?
      render json: new_record, status: :created
    else
      render status: :bad_request, json: new_record.errors
    end
  rescue ActionController::ParameterMissing => e
    render status: :bad_request, json: { error: e.message }
  end

  def update
    updated_record = Bank.update_bank_by_id(
      params[:id], @current_user, model_params(Bank, "bank"))
    if updated_record.errors.empty?
      render json: updated_record
    else
      render status: :unprocessable_entity, json: updated_record.errors
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  rescue ActionController::ParameterMissing => e
    render status: :bad_request, json: { error: e.message }
  end
end
