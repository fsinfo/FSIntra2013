# == Schema Information
#
# Table name: minutes_items
#
#  id         :integer          not null, primary key
#  date       :date
#  title      :string(255)
#  content    :text
#  order      :integer
#  minute_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Minutes::Item do
  pending "add some examples to (or delete) #{__FILE__}"
end
