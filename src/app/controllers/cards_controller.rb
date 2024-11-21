class CardsController < ApplicationController
  include Crud

  def initialize
    @model = Card
  end
end
