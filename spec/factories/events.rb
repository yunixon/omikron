# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name { Faker::Lorem.words(rand(1..5)).join(' ') }
    association :event_type
    first_side { Faker::Lorem.words(rand(1..3)).join(' ') }
    second_side { Faker::Lorem.words(rand(1..3)).join(' ') }
    datetime_start "2014-07-26 03:30:34"
    complete false
    count { Faker::Lorem.characters(rand(3..5)) } #0-0 или 12-14
    association :complete_type
  end
end