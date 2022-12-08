class AddTimeToPotatoTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :potato_transactions, :time, :datetime, null: false
  end
end
