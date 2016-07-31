FactoryGirl.define do
  factory :stock_holding do
    id { SecureRandom.uuid }
    portfolio
    active true
  end
end
