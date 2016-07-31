class CreateCashTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :cash_trades, id: :uuid do |t|
      t.uuid :cash_holding_id, null: false
      t.decimal :quantity, precision: 15, scale: 2

      t.timestamps
    end

    add_index :cash_trades, :cash_holding_id
  end
end
