# frozen_string_literal:true

class CreatePotatoTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :potato_transactions do |t|
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
      t.integer :direction, null: false

      t.references :user, null: false

      t.timestamps
    end
  end
end
