# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    association :user, factory: :user
    bet_id 1 # Не обязательная ассоциация, здесь bet_id может быть и nil
    complete false
    amount "9.99"
    t_type 1
    complete_type 1
  end
end
