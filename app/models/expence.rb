class Expence < ApplicationRecord
  enum :expence_type, { spending: "SPENDING", paytment: "PAYMENT" }, suffix: true
  belongs_to :card

  def self.filter_by_card(card_id)
    where(card_id: card_id)
  end
end
