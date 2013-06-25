# == Schema Information
#
# Table name: minutes_attendances
#
#  id        :integer          not null, primary key
#  absent    :string(255)
#  user_id   :integer
#  minute_id :integer
#

class Minutes::Attendance < ActiveRecord::Base
	validates_presence_of :minute
	validates_presence_of :user
	validates_uniqueness_of [:minute, :user]

	belongs_to :minute
	belongs_to :user
end
