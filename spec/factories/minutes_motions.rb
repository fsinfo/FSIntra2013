# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_motion, :class => 'Minutes::Motion' do
    order 1
    mover nil
    pro 1
    con 1
    abs 1
    rationale "MyText"
    amount 1
    minutes_item nil
    approved false
  end
end
