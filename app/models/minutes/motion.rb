# == Schema Information
#
# Table name: minutes_motions
#
#  id         :integer          not null, primary key
#  rationale  :text
#  mover_id   :integer
#  amount     :decimal(, )
#  pro        :integer
#  abs        :integer
#  con        :integer
#  created_at :datetime
#  updated_at :datetime
#  item_id    :integer
#

class Minutes::Motion < ActiveRecord::Base
  belongs_to :mover, :class_name => "User"
  belongs_to :item

  validates_presence_of :rationale, :mover, :pro, :abs, :con
end
