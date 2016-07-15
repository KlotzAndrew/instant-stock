class CreateCashHoldings < ActiveRecord::Migration[5.0]
  def change
    create_table :cash_holdings, id: :uuid do |t|
      t.decimal :amount, precision: 15, scale: 2
      t.string :currency, null: false
      t.uuid :portfolio_id, null: false

      t.timestamps
    end
  end
end
