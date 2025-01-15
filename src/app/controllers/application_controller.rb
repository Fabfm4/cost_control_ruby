class ApplicationController < ActionController::API
  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, Rails.application.config.jwt_secret, "HS256"
  end

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[0]["user_id"])
      @require_auth = true
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def jwt_decode(token)
    JWT.decode token, Rails.application.config.jwt_secret, true, { algorithm: "HS256" }
  end

  # def add_user_id_to_params
  #   puts @model_name
  #   params[@model_name][:user_id] = @current_user.id
  # end
end
