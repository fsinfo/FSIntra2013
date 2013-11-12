# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_attendance, :class => 'Minutes::Attendance' do
    user nil
    minute nil
    type ""
  end
end
