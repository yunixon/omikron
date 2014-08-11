# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :complete_type do
    association :event, factory: :event
    result { Faker::Number.between(0, 3).to_i }
    description { Faker::Lorem.sentence }
  end
end
