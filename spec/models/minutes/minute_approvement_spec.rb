# == Schema Information
#
# Table name: minutes_minute_approvements
#
#  id                 :integer          not null, primary key
#  minute_id          :integer
#  approved_minute_id :integer
#  pro                :integer
#  con                :integer
#  abs                :integer
#  apparent_majority  :boolean
#  approved           :boolean
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_minutes_minute_approvements_on_approved_minute_id  (approved_minute_id)
#  index_minutes_minute_approvements_on_minute_id           (minute_id)
#

require 'spec_helper'

describe Minutes::MinuteApprovement do
  pending "add some examples to (or delete) #{__FILE__}"
end
