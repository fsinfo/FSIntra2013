# == Schema Information
#
# Table name: minutes_attendances
#
#  user_id   :integer
#  minute_id :integer
#  type      :string(255)
#
# Indexes
#
#  index_minutes_attendances_on_minute_id              (minute_id)
#  index_minutes_attendances_on_user_id                (user_id)
#  index_minutes_attendances_on_user_id_and_minute_id  (user_id,minute_id)
#

class Minutes::Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :minute

  # self.primary_key = "user_id, minute_id"
  # self.primary_key = [:user_id, :minute_id]
end
