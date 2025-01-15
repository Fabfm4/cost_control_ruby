class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.float :total_amount
      t.float :charge_amount
      t.float :rest_amount
      t.datetime :transaction_date, null: false
      t.integer :number_payment
      t.string :description, null: true
      t.string :expence_type, default: 'SPENDING'
      t.references :user, null: false, foreign_key: true
      t.references :sub_category, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true


      t.timestamps
    end
  end
end
