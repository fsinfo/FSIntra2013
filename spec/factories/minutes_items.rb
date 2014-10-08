# == Schema Information
#
# Table name: minutes_items
#
#  id         :integer          not null, primary key
#  date       :date
#  title      :string(255)
#  content    :text
#  order      :integer
#  minute_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_minutes_items_on_minute_id  (minute_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_item, :class => 'Minutes::Item' do
    date "2013-09-01"
    title "MyString"
    content "MyText"
    order 1
    minute nil
  end
end
