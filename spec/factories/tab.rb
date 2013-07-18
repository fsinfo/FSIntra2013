FactoryGirl.define do
  factory :tab do
    association :user

    trait(:running) {status Tab::STATUS_RUNNING}

    trait :with_beverage_tabs do
      after :build do |tab| 
        FactoryGirl.create_list :beverage_tab, 5, :tab => tab
      end
    end

    trait(:invalid) { status 'invalid' }
  end
end