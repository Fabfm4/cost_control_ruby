class UsersController < ApplicationController
  include Crud

  def initialize
    @model = User
    @model_name = "user"
  end
end
