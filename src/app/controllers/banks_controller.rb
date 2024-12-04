class BanksController < ApplicationController
  include Crud

  def initialize
    @model = Bank
    @model_name = "bank"
  end
end
