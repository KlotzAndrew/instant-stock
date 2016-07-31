FactoryGirl.define do
  factory :cash_trade do
    id { SecureRandom.uuid }
    cash_holding
    quantity 1_000_000
  end
end
