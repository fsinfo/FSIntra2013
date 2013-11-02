# == Schema Information
#
# Table name: minutes_motions
#
#  id         :integer          not null, primary key
#  order      :integer
#  mover_id   :integer
#  pro        :integer
#  con        :integer
#  abs        :integer
#  rationale  :text
#  amount     :integer
#  item_id    :integer
#  approved   :boolean
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_minutes_motions_on_item_id   (item_id)
#  index_minutes_motions_on_mover_id  (mover_id)
#

require 'spec_helper'

describe Minutes::Motion do
  pending "add some examples to (or delete) #{__FILE__}"
end
