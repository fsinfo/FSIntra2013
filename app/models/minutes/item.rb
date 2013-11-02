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

class Minutes::Item < ActiveRecord::Base
  belongs_to :minute, class_name: 'Minutes::Minute'
  has_many :motions, class_name: 'Minutes::Motion'
end
