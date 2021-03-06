# == Schema Information
#
# Table name: minutes_approvements
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
#  index_minutes_approvements_on_approved_minute_id  (approved_minute_id)
#  index_minutes_approvements_on_minute_id           (minute_id)
#

class Minutes::Approvement < ActiveRecord::Base # TODO rename approval
  belongs_to :minute # minute in which this approval was decided
  belongs_to :approved_minute, class_name: "Minutes::Minute" # previous minute which was approved
  
  validate :vote_presence

  after_save :set_approved_date
  before_destroy :unset_approved_date


  private

  def set_approved_date
    approved_minute.update approved_date: minute.date if approved?
  end

  def unset_approved_date
    approved_minute.update approved_date: nil
  end

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
