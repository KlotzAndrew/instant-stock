FactoryGirl.define do
  factory :stock_holding do
    id { SecureRandom.uuid }
    portfolio
    active true
  end

  trait :with_stock_trade do
    after(:build) do |holding|
      stock = build_list :stock, 1
      stock.first.stock_holdings << holding
      holding.stock = stock.first

      trade = build_list :stock_trade, 1, stock_holding: holding
      holding.stock_trades << trade
    end
  end
end
