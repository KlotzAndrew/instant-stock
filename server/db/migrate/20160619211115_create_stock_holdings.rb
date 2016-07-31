class CreateStockHoldings < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_holdings, id: :uuid do |t|
      t.boolean :active, default: true, null: false
      t.uuid :portfolio_id, null: false
      t.uuid :stock_id, null: false

      t.timestamps
    end

    add_index :stock_holdings, :portfolio_id
    add_index :stock_holdings, :stock_id
  end
end
