FactoryGirl.define do
  factory :holding do
    id { SecureRandom.uuid }
    portfolio
    active true
  end
end
