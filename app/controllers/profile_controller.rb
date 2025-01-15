class ProfileController < ApplicationController
  before_action :authorize_request

  def me
    if @current_user
      render json: @current_user
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end
end
