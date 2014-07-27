# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length = 8) }
    role { :user }
    factory :first_user do
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length = 8) }
      role { :user }
    end
    factory :second_user do
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length = 8) }
      role { :admin }
    end
  end
end
