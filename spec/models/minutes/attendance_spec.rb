# == Schema Information
#
# Table name: minutes_attendances
#
#  id        :integer          not null, primary key
#  absent    :string(255)
#  user_id   :integer
#  minute_id :integer
#

require 'spec_helper'

describe Minutes::Attendance do
  pending "add some examples to (or delete) #{__FILE__}"
end
