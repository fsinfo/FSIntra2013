# == Schema Information
#
# Table name: minutes_minutes
#
#  id                       :integer          not null, primary key
#  date                     :date
#  keeper_of_the_minutes_id :integer
#  chairperson_id           :integer
#  released_date            :date
#  has_quorum               :boolean
#  created_at               :datetime
#  updated_at               :datetime
#  guests                   :text
#  draft_sent_date          :date
#

require 'spec_helper'

describe Minutes::Minute do
  pending "add some examples to (or delete) #{__FILE__}"
end
