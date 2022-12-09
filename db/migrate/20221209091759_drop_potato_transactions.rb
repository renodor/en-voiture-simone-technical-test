class DropPotatoTransactions < ActiveRecord::Migration[7.0]
  def change
    drop_table :potato_transactions
  end
end
