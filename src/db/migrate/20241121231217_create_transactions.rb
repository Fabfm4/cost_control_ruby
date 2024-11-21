class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.float :amout
      t.references :card, null: false, foreign_key: true
      t.string :transaction_type, default: 'SPENDING'
      t.string :description, null: true

      t.timestamps
    end
  end
end
