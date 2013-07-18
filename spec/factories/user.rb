FactoryGirl.define do
  factory :user, class: User, parent: :person do 
    sequence(:loginname) { |n| "loginname_#{n}"}

    factory :user_on_beverage_list do
      on_beverage_list true
    end

    trait(:kuehlschrank) do
      after(:build) { |user| FsLdap.add_groups(user.loginname, 'kuehlschrank') }
    end

    trait(:fsr) do
      after(:build) { |user| FsLdap.add_groups(user.loginname, 'fsr') }
    end
  end
end