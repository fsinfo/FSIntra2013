# == Schema Information
#
# Table name: minutes_attendances
#
#  user_id   :integer
#  minute_id :integer
#  type      :string(255)
#  id        :integer          not null, primary key
#

class Minutes::Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :minute
end
