# == Schema Information
#
# Table name: minutes_minutes
#
#  id                       :integer          not null, primary key
#  date                     :date
#  keeper_of_the_minutes_id :integer
#  chairperson_id           :integer
#  released_date            :date
#  has_quorum               :boolean
#  created_at               :datetime
#  updated_at               :datetime
#  guests                   :text
#  draft_sent_date          :date
#  type                     :string(255)
#  approved_date            :date
#
# Indexes
#
#  index_minutes_minutes_on_chairperson_id            (chairperson_id)
#  index_minutes_minutes_on_keeper_of_the_minutes_id  (keeper_of_the_minutes_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_minute, :class => 'Minutes::Minute' do
    date "2013-08-12"
    keeper_of_the_minutes nil
    chairperson nil
    released_date "2013-08-12"
    has_quorum false
  end
end
