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

  def signin
    signin_params = auth_signin_params
    if signin_params[:email].nil?
      render status: :bad_request, json: { email: "Is required" }
      return
    end
    user = User.find_by(email: signin_params[:email])
    if user.nil?
      render json: { error: "unauthorized" }, status: :unauthorized
      return
    end
    render status: :ok, json: { token: jwt_encode({ user_id: user.id }) }
  end

  def signup
    signup_params = auth_signup_params
    if signup_params[:email].nil? 
      render status: :bad_request, json: { email: "Is required" }
      return
    end
    if signup_params[:user_name].nil? 
      render status: :bad_request, json: { user_name: "Is required" }
      return
    end

    user = User.find_by(email: signup_params[:email])
    if user.nil?
      user = User.new(signup_params)
      if user.save
        render status: :created, json: { token: jwt_encode({ user_id: user.id }) }
        return
      end
      render status: :unprocessable_entity, json: user.errors
      return
    end
    render json: { error: "User already exists" }, status: :bad_request


  end

  private
  def admin_user_params
    params.expect(user: [:user_name, :email])
  end

  private
  def auth_signin_params
    params.require(:login) do |p|
      p.require(:email)
    end
  end

  private
  def auth_signup_params
    params.expect(signup: [:user_name, :email])
  end
end
