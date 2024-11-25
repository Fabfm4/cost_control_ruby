class CardsController < ApplicationController
  include Crud

  def initialize
    @model = Card
    @model_name = "card"
  end
end
