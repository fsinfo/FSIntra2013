FactoryGirl.define do
  factory :tab do
    association :user

    trait :with_beverage_tabs do
      after :build do |tab| 
        FactoryGirl.create_list :beverage_tab, 5, :tab => tab
      end
    end

    trait(:invalid) { status 'invalid' }
    trait(:unpaid) { status Tab::STATUS_UNPAID }
    trait(:running) { status Tab::STATUS_RUNNING}
    trait(:marked_as_paid) { status Tab::STATUS_MARKED_AS_PAID }
    trait(:paid) { status Tab::STATUS_PAID }
  end
end