class Card < ApplicationRecord
  enum :transaction_type, { spending: "SPENDING", paytment: "PAYMENT" }, suffix: true
  belongs_to :bank

end
