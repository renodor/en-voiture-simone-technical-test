class CreatePotatoPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :potato_prices do |t|
      t.decimal :price, precision: 10, scale: 2, default: 0.0, null: false
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
