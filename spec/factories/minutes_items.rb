# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_item, :class => 'Minutes::Item' do
    date "2013-09-01"
    title "MyString"
    content "MyText"
    order 1
    minute nil
  end
end
