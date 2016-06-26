class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios, id: :uuid do |t|
      t.string :name
      t.decimal :cash, default: 0,  precision: 15, scale: 2

      t.timestamps
    end
  end
end
