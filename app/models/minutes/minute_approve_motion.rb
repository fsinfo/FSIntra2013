# == Schema Information
#
# Table name: minutes_minute_approve_motions
#
#  id                     :integer          not null, primary key
#  pro                    :integer
#  abs                    :integer
#  con                    :integer
#  minute_approve_item_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#  minute_id              :integer
#

class Minutes::MinuteApproveMotion < ActiveRecord::Base
	# the minute that is to be approved
	belongs_to :minute
	# one minute can only be approved once
	validates_uniqueness_of :minute_id

	# the item of the minute of the approving session
	belongs_to :minute_approve_item
end
