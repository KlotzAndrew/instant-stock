FactoryGirl.define do
  factory :cash_holding do
    id { SecureRandom.uuid }
    currency CashHolding::USD
    portfolio
  end

  trait :with_cash_trade do
    after(:build) do |holding|
      trade = build_list :cash_trade, 1, cash_holding: holding
      holding.cash_trades << trade
    end
  end
end
