class CreateStockTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_trades, id: :uuid do |t|
      t.uuid :stock_holding_id, null: false
      t.integer :quantity, null: false
      t.decimal :enter_price, precision: 15, scale: 2
      t.decimal :exit_price, precision: 15, scale: 2
      t.datetime :exit_time

      t.timestamps
    end

    add_index :stock_trades, :stock_holding_id
  end
end
