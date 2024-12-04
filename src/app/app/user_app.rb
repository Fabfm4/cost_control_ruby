class UserApp
  include ExceptionShare

  def create_user(params)
    user_params = user_params(params)
    user = User.new(user_params)
    if user.save
      user
    else
      raise ExceptionShare::ModelException.new("error model", 400, 0, user.errors.to_hash(true))
    end
  end

  private
  def user_params(params)
    params.expect(user: [:user_name, :email])
  end

end