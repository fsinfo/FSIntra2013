namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    50.times do |n|
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      email = "#{n}@test.de"
      User.create!( firstname: fname,
        lastname: lname,
        email: email,
        zip: 10000+rand(89999),
        street: Faker::Address.street_address,
        phone: Faker::PhoneNumber.phone_number,
        misc: Faker::Lorem.sentence,
        birthday: Time.at(rand * Time.now.to_i),
        city: 'Kaiserslautern'
        )
    end
    50.times do |n|
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      email = "#{n+50}@test.de"
      Person.create!( firstname: fname,
        lastname: lname,
        email: email,
        zip: 10000+rand(89999),
        street: Faker::Address.street_address,
        phone: Faker::PhoneNumber.phone_number,
        misc: Faker::Lorem.sentence,
        birthday: Time.at(rand * Time.now.to_i),
        city: 'Kaiserslautern'
        )
    end
    Beverage.create!( name: 'Spezi', capacity: 0.5, price: 60, available: true )
    Beverage.create!( name: 'Apfelsaftschorle', capacity: 0.7, price: 70, available: true )
    Beverage.create!( name: 'Wasser', capacity: 0.7, price: 40, available: true )
    Beverage.create!( name: 'Bier', capacity: 0.5, price: 85, available: true )
    Beverage.create!( name: 'Braumeister Limonade', capacity: 0.5, price: 90, available: true )
    Beverage.create!( name: 'Red Bull', capacity: 0.33, price: 100, available: true )
    Beverage.create!( name: 'Mate', capacity: 0.5, price: 100, available: true )
    Beverage.create!( name: 'Braumeister Limonade', capacity: 0.33, price: 80, available: true )
    Beverage.create!( name: 'Spezial 1', capacity: 0.5, price: 85, available: false )
    Beverage.create!( name: 'Spezial 2', capacity: 0.5, price: 85, available: false )
  end
end