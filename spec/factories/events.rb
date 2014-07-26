# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    event_type 1
    first_side "MyString"
    string "MyString"
    second_side "MyString"
    datetime_start "2014-07-26 03:30:34"
    complete false
    count "MyString"
    complete_type 1
  end
end
