class CreateTrades < ActiveRecord::Migration[5.0]
  def change
    create_table :trades, id: :uuid do |t|
      t.integer :holding_id, null: false
      t.integer :quantity, null: false
      t.decimal :enter_price, null: false, precision: 15, scale: 2
      t.decimal :exit_price, null: false, precision: 15, scale: 2

      t.timestamps
    end

    add_index :trades, :holding_id
  end
end
