# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bet do
    association :user, factory: :user
    association :event, factory: :event
    sum 5.0
    side_bet { Faker::Number.between(0, 2).to_i }
    complete false
    complete_type { Faker::Number.between(0, 3).to_i }
  end
end
