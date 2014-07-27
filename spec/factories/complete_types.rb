# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :complete_type, :class => 'CompleteTypes' do
    result "MyString"
    description "MyText"
  end
end
