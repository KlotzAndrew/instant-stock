 class CreateCashHoldings < ActiveRecord::Migration[5.0]
  def change
    create_table :cash_holdings, id: :uuid do |t|
      t.string :currency, null: false
      t.uuid :portfolio_id, null: false

      t.timestamps
    end

    add_index :cash_holdings, :portfolio_id
  end
end
