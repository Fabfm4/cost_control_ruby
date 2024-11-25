class TransactionsController < ApplicationController
  include Crud

  def initialize
    @model = Transaction
    @model_name = "transaction"
  end

  def index
    card = params.include?(:card_id) ? params[:card_id].to_i : nil
    if !card.nil?
      render json: Transaction.filter_by_card(card)
    else
      super
    end
  end

  def show
    card = params.include?(:card_id) ? params[:card_id].to_i : nil
    if !card.nil?
      render json: Transaction.filter_by_card(card).find(params[:id])
    else
      super
    end
  rescue ActiveRecord::RecordNotFound
    render status: :not_found
  end

  def create
    card = Card.find(params[:card_id])
    params[:transaction][:card_id] = card.id
    super
  rescue ActiveRecord::RecordNotFound
    render json: { "error": "Card not found" }, status: :bad_request
  end
end
