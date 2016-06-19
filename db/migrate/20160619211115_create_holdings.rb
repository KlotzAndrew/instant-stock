class CreateHoldings < ActiveRecord::Migration[5.0]
  def change
    create_table :holdings, id: :uuid do |t|
      t.boolean :active, default: true, null: false
      t.bigint :portfolio_id, null: false
      t.bigint :stock_id, null: false

      t.timestamps
    end

    add_index :holdings, :portfolio_id
    add_index :holdings, :stock_id
  end
end
