FactoryGirl.define do
  factory :portfolio do
    id { SecureRandom.uuid }
    name { Faker::Company.name }
  end

  trait :with_cash do
    after(:build) do |portfolio|
      holding = build_list :cash_holding, 1, :with_cash_trade, portfolio: portfolio
      portfolio.cash_holdings << holding
    end
  end
end
