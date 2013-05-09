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
	belongs_to :minute
end
