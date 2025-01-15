class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :last_four_digits
      t.integer :deadline_payment
      t.integer :cutoff_day_payment
      t.string :card_type, default: 'credit'
      t.references :bank, null: false, foreign_key: true
      t.boolean :active, null: false, default: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
