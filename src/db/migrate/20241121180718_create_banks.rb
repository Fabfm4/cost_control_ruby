class CreateBanks < ActiveRecord::Migration[8.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.boolean :active, null: false, default: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
