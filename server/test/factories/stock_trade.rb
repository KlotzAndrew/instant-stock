FactoryGirl.define do
  factory :stock_trade do
    id { SecureRandom.uuid }
    stock_holding
    quantity { rand(10..100) }
    enter_price nil
    exit_price nil
  end
end
