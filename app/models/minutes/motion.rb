# == Schema Information
#
# Table name: minutes_motions
#
#  id                :integer          not null, primary key
#  order             :integer
#  mover_id          :integer
#  pro               :integer
#  con               :integer
#  abs               :integer
#  rationale         :text
#  amount            :integer
#  item_id           :integer
#  approved          :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  apparent_majority :boolean
#
# Indexes
#
#  index_minutes_motions_on_item_id   (item_id)
#  index_minutes_motions_on_mover_id  (mover_id)
#

class Minutes::Motion < ActiveRecord::Base
  belongs_to :mover, class_name: 'User'
  belongs_to :item, class_name: 'Minutes::Motion'

  validates_presence_of :mover
  validates_presence_of :rationale
  validate :vote_presence

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

  private

  # Checks that either pro, con and abs are set, or the apparent_majority flag is set.
  def vote_presence
    unless all_votes_specified? ^ apparent_majority
      errors.add(:base, "Entweder ein Abstimmungsergebnis oder augenscheinliche Mehrheit auswählen.")
    end
    if any_votes_specified? and apparent_majority
      errors.add(:base, "Augenscheinliche Mehrheit und Abstimmungsergebnis nicht möglich.")
    end
  end

  # Returns true, iff. all votes are specified.
  def all_votes_specified?
    # if at least one value is nil, return false
    return false if (pro.nil? or pro == "") or
                    (con.nil? or con == "") or
                    (abs.nil? or abs == "")
    # otherwise return true
    return true
  end

  # Returns true, iff. any vote is specified
  def any_votes_specified?
    !((pro.nil? or pro == "") and
    (con.nil? or con == "") and
    (abs.nil? or abs == ""))
  end
end
