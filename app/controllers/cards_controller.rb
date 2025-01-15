class CardsController < ApplicationController
  include Crud

  before_action :authorize_request

  def initialize
    @model = Card
    @model_name = "card"
    @has_user = true
  end
end
