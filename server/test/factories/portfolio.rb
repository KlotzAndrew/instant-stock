FactoryGirl.define do
  factory :portfolio do
    id { SecureRandom.uuid }
    name { Faker::Company.name }
    promo_portfolio true
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

  trait :with_stock_holding do
    after(:build) do |portfolio|
      stock         = FactoryGirl.build :stock
      stock_holding = FactoryGirl.build :stock_holding,
                                        stock:     stock,
                                        portfolio: portfolio
      portfolio.stock_holdings << stock_holding
      portfolio.stocks << stock
    end
  end

  trait :with_cash_holding do
    after(:build) do |portfolio|
      cash_holding = FactoryGirl.build :cash_holding,
                                       portfolio: portfolio
      portfolio.cash_holdings << cash_holding
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
