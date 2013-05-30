FactoryGirl.define do
  factory :beverage do 
    sequence(:name) { |n| "Beverage #{n}" }
    description 'Lorem ipsum'
    price 5.0
    capacity 5.0
    available true

    factory :unavailable_beverage do
      available false
    end
  end 
end