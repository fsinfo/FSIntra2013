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

class Minutes::Motion < ActiveRecord::Base
  belongs_to :mover, class_name: 'User'
  belongs_to :item, class_name: 'Minutes::Motion'

  validates_presence_of :mover
  validates_presence_of :rationale
  validates_presence_of :pro, :con, :abs

  # Prints the Cent-value as €-String
  # e.g.
  #   m = Motion.new
  #   m.amount = 9998
  #   m.currency
  #   # => '99,98 €'
  def amount_in_currency
    return unless amount
  	a = amount / 100
  	b = amount % 100
  	b = "0#{b}" if b < 10
  	"#{a},#{b} €"
  end
end
