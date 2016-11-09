FactoryGirl.define do
  factory :stock do
    id { SecureRandom.uuid }
    ticker { 'GOOG' }
    stock_exchange { [*'A'..'Z'].sample(3).join }
    name { Faker::Company.name }
    currency CashHolding::USD
    last_quote_time { Time.zone.now }
    last_quote { Faker::Number.decimal(3, 2) }
  end
end
