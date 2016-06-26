FactoryGirl.define do
  factory :portfolio do
    id { SecureRandom.uuid }
    name { Faker::Company.name }
    cash { Faker::Number.decimal(10, 2) }
  end

  trait :with_cash_holding do
    after(:build) do |portfolio|
      holding = build_list :holding, 1, portfolio: portfolio
      portfolio.holdings << holding
    end
  end
end
