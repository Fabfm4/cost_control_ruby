class BanksController < ApplicationController
  include Crud

  def initialize
    @model = Bank
  end
end
