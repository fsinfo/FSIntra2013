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
#  type                     :string(255)
#
# Indexes
#
#  index_minutes_minutes_on_chairperson_id            (chairperson_id)
#  index_minutes_minutes_on_keeper_of_the_minutes_id  (keeper_of_the_minutes_id)
#

class Minutes::Minute < ActiveRecord::Base
  belongs_to :keeper_of_the_minutes, class_name: 'User'
  belongs_to :chairperson, class_name: 'User'

  has_many :items, -> { order '"order" ASC' }, class_name: 'Minutes::Item'
  has_many :approvements

  # Attendances are defined in the 'base-join-table' attendances,
  # which also has a column 'type'. This is used in order to
  # distinguish between FSR attendees and guests (extendable).
  has_many :fsr_attendances, -> { where type: :fsr }, class_name: 'Minutes::Attendance'
  has_many :fsr_attendants, through: :fsr_attendances, source: :user
  has_many :guest_attendances, -> { where type: :guest }, class_name: 'Minutes::Attendance'
  has_many :guest_attendants, through: :guest_attendances, source: :user

  # These scopes reflect the lifecycle of a minute.
  # If a minute is created, it stars being _open_ and a
  # draft can be sent for approval.
  # At some time the keeper of this minute _releases_ it.
  # In the next board meeting this minute can be _accepted_.
  # Maybe in some future time this could be encoded into a db field.
  scope :not_approved, -> { where("id NOT IN (SELECT approved_minute_id FROM minutes_approvements)") }
  scope :open, -> { not_approved.where("released_date IS NULL") }
  scope :released, -> { not_approved.where("released_date IS NOT NULL") }
  scope :accepted, -> { where("id IN (SELECT approved_minute_id FROM minutes_approvements)") }

  # By default every minute has as first item 'agenda aggreement'
  # and as second item 'approvement of previous minutes'
  # This methods enriches the stored items by those two.
  def item_titles
    ['Festlegung der Tagesordnung', 'Genehmigung von Protokollen'] + items.pluck(:title)
  end

  validates_presence_of :chairperson_id
  validates_presence_of :keeper_of_the_minutes_id
  validates_presence_of :date
end