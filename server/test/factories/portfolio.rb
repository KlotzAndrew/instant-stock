FactoryGirl.define do
  factory :portfolio do
    id { SecureRandom.uuid }
    name { Faker::Company.name }
  end

  trait :with_cash do
    after(:build) do |portfolio|
      holding = build_list :cash_holding,
                           1,
                           :with_cash_trade,
                           portfolio: portfolio
      portfolio.cash_holdings << holding
    end
  end

  trait :with_cash_and_stock do
    after(:build) do |portfolio|
      cash_holding = build_list :cash_holding,
                                1,
                                :with_cash_trade,
                                portfolio: portfolio
      portfolio.cash_holdings << cash_holding

      stock_holding = build_list :stock_holding,
                                 1,
                                 :with_stock_trade,
                                 portfolio: portfolio
      portfolio.stock_holdings << stock_holding
    end
  end
end
