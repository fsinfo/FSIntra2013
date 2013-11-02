# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_minute, :class => 'Minutes::Minute' do
    date "2013-08-12"
    keeper_of_the_minutes nil
    chairperson nil
    released_date "2013-08-12"
    has_quorum false
  end
end
