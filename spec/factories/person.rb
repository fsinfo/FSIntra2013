FactoryGirl.define do
  factory :person do 
    firstname 'Firstname'
    sequence(:lastname) { |n| "Lastname #{id}" }
    street    'Street'
    zip       '12345'
    city      'City'
    sequence (:email) { |n| "user_#{n}@fachschaft.cs.uni-kl.de" }
    phone     ''
    birthday  Date.new(1980,12,12)
    misc      'Lorem ipsum misc'
  end
end