# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bet do
    association :user
    association :event
    sum { Faker::Number.decimal(3, 2) }
    side_bet { Faker::Number.between(0, 1) }
    complete false
    association :complete_type
  end
end
