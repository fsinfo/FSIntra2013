# == Schema Information
#
# Table name: minutes_attendances
#
#  id        :integer          not null, primary key
#  user_id   :integer
#  minute_id :integer
#  a_type    :string(255)
#
# Indexes
#
#  index_minutes_attendances_on_minute_id  (minute_id)
#  index_minutes_attendances_on_user_id    (user_id)
#

require 'spec_helper'

describe Minutes::Attendance do
  pending "add some examples to (or delete) #{__FILE__}"
end
