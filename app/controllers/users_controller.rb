
class UsersController < ApplicationController

  attr_accessor :app

  def initialize
    @app = UserApp.new
  end

  def create
    result = @app.create_user(params)
    render json: result, status: :created
    rescue ExceptionShare::ModelException => e
      puts e.data
      render status: e.status, json: {errors: e.data}
    rescue ActionController::ParameterMissing
      render status: :bad_request, json: result
  end

end
