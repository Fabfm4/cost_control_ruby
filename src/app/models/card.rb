class Card < ApplicationRecord
  enum :card_type, { credit: "credit", debit: "debit" }, suffix: true
  belongs_to :bank
  belongs_to :user
end
