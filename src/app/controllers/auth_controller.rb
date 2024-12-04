class AuthController < ApplicationController
  def admin
    user_params = admin_user_params
    user_params[:user_role] = "ADMIN"
    user = User.new(user_params)
    if user.save
      render status: :created, json: user
      return
    end
    render status: :unprocessable_entity, json: user.errors
  end

  def login
    login_params = auth_login_params
    if login_params[:email].nil?
      render status: :bad_request, json: { email: "Is required" }
      return
    end
    user = User.find_by(email: login_params[:email])
    if user.nil?
      render json: { error: "unauthorized" }, status: :unauthorized
      return
    end
    render status: :ok, json: { token: jwt_encode({ user_id: user.id }) }
  end

  private
  def admin_user_params
    params.expect(user: [:user_name, :email])
  end

  private
  def auth_login_params
    params.require(:login) do |p|
      p.require(:email)
    end
  end
end
