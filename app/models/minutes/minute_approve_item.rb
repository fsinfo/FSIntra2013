# This class doesn't extend "Minutes::Item" on porpuse!
class Minutes::MinuteApproveItem < ActiveRecord::Base
	belongs_to :minute
	has_many :minute_approve_motions

	accepts_nested_attributes_for :minute_approve_motions
end