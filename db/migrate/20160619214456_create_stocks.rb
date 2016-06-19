class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks, id: :uuid do |t|
      t.string :ticker, null: false
      t.string :stock_exchange, null: false
      t.string :name

      t.datetime :last_quote_time
      t.decimal :last_quote, precision: 15, scale: 2

      t.timestamps
    end
  end
end
