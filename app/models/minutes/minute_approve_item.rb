# == Schema Information
#
# Table name: minutes_minute_approve_items
#
#  id         :integer          not null, primary key
#  order      :integer
#  minute_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# This class doesn't extend "Minutes::Item" on porpuse!
class Minutes::MinuteApproveItem < ActiveRecord::Base
	belongs_to :minute
	has_many :minute_approve_motions

	accepts_nested_attributes_for :minute_approve_motions
end
