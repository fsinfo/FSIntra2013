# == Schema Information
#
# Table name: minutes_attendances
#
#  absent    :string(255)
#  user_id   :integer
#  minute_id :integer
#  id        :integer          not null, primary key
#
# Indexes
#
#  index_minutes_attendances_on_id  (id)
#

class Minutes::Attendance < ActiveRecord::Base

	# absent status 
  STATUSES = ['', 'absent', 'unexcused']
  validates :absent, :inclusion => { :in => STATUSES }

	validates_presence_of :minute, :message => "validates_presence_of minute -- is kaputt"
	validates_presence_of :user, :message => "validates_presence_of user -- is kaputt"
	validates_uniqueness_of :user, :scope => :minute, :message => "validates_uniqueness_of -- is kaputt"

	belongs_to :minute
	belongs_to :user
end
