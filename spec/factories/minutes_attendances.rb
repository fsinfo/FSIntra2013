# == Schema Information
#
# Table name: minutes_attendances
#
#  id        :integer          not null, primary key
#  user_id   :integer
#  minute_id :integer
#  a_type    :string(255)
#
# Indexes
#
#  index_minutes_attendances_on_minute_id  (minute_id)
#  index_minutes_attendances_on_user_id    (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_attendance, :class => 'Minutes::Attendance' do
    user nil
    minute nil
    type ""
  end
end
