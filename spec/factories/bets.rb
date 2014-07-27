# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bet do
    association :user, factory: :user
    association :event, factory: :event
    sum { Faker::Number.decimal(3, 2) }
    side_bet { Faker::Number.between(0, 1) }
    complete false
    complete_type { Faker::Number.between(0, 3) }
  end
end
