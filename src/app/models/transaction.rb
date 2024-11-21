class Transaction < ApplicationRecord
  enum :card_type, { credit: "credit", debit: "debit" }, suffix: true
  belongs_to :card
end
