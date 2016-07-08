FactoryGirl.define do
  factory :trade do
    id { SecureRandom.uuid }
    holding
    quantity { rand(10..100) }
    enter_price nil
    exit_price nil
  end
end
