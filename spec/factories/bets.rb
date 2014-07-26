# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bet do
    user_id 1
    event_id 1
    sum "9.99"
    side_bet 1
    complete false
    complete_type 1
  end
end
