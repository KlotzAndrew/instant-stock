class CreateDayBars < ActiveRecord::Migration[5.0]
  def change
    create_table :day_bars, id: :uuid do |t|
      t.uuid :stock_id, null: false
      t.string :data_source, null: false
      t.datetime :quote_time, null: false

      t.decimal :high, precision: 15, scale: 2
      t.decimal :open, precision: 15, scale: 2
      t.decimal :close, precision: 15, scale: 2
      t.decimal :low, precision: 15, scale: 2
      t.decimal :adjusted_close, precision: 15, scale: 2
      t.decimal :volume, precision: 15, scale: 2

      t.timestamps
    end

    add_index :day_bars, [:data_source, :stock_id]
  end
end
