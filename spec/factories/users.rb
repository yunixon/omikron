# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Facker::Internet.email }
    password { Facker::Internet.password }
  end
end
