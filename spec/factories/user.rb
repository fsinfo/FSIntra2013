FactoryGirl.define do
  factory :user do 
    firstname 'Firstname'
    sequence(:lastname) { |n| "Lastname #{id}" }
    street    'Street'
    zip       '12345'
    city      'City'
    sequence (:email) { |n| "#{n}@fachschaft.cs.uni-kl.de" }
    phone     ''
    birthday  Date.new(1980,12,12)
    misc      'Lorem ipsum misc'

    factory :user_on_beverage_list do
      on_beverage_list true
    end
  end
end