# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { :user }
    factory :first_user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      role { :user }
    end
    factory :second_user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      role { :admin }
    end
  end
end
