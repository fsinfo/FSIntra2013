class Minutes::Attendance < ActiveRecord::Base
	validates_presence_of :minute
	validates_presence_of :user
	validates_uniquenes_of [:minute, :user]

	belongs_to :minute
	belongs_to :user
end