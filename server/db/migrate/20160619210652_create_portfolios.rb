class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios, id: :uuid do |t|
      t.string :name
      t.boolean :promo_portfolio, default: false, null: false

      t.timestamps
    end
  end
end
