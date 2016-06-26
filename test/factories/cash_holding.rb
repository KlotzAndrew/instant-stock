FactoryGirl.define do
  factory :cash_holding do
    id { SecureRandom.uuid }
    currency CashHolding::USD
    portfolio
    amount 1_000_000_000
  end
end
