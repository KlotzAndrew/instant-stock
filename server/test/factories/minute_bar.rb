FactoryGirl.define do
  factory :minute_bar do
    id { SecureRandom.uuid }
    stock
    data_source { Faker::Company.name }
    quote_time { Time.zone.now }
    high { Faker::Number.decimal(3, 2) }
    open { Faker::Number.decimal(3, 2) }
    close { Faker::Number.decimal(3, 2) }
    low { Faker::Number.decimal(3, 2) }
    adjusted_close { Faker::Number.decimal(3, 2) }
    volume { Faker::Number.decimal(5) }
  end
end
