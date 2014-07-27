# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :complete_type do
    result { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    association :event
  end
end
