FactoryGirl.define do
  factory :beverage_tab do 
    sequence(:name) { |n| "Beverage #{n}"}
    capacity 5
    price 5
    count 5
  end 
end