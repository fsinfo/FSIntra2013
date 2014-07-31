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
#  approved_date            :date
#
# Indexes
#
#  index_minutes_minutes_on_chairperson_id            (chairperson_id)
#  index_minutes_minutes_on_keeper_of_the_minutes_id  (keeper_of_the_minutes_id)
#

class Minutes::Minute < ActiveRecord::Base
  belongs_to :keeper_of_the_minutes, class_name: 'User'
  belongs_to :chairperson, class_name: 'User'

  has_many :items, -> { order '"order" ASC' }, class_name: 'Minutes::Item', dependent: :destroy
  
  has_many :approvements, dependent: :destroy
  has_one :approving, inverse_of: :approved_minute, class_name: 'Minutes::Approvement', foreign_key: :approved_minute_id

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
  scope :not_approved, -> { where("approved_date IS NULL") }
  scope :open, -> { not_approved.where("released_date IS NULL") }
  scope :released, -> { not_approved.where("released_date IS NOT NULL") }
  scope :accepted, -> { where "approved_date IS NOT NULL" }

  # By default every minute has as first item 'agenda aggreement'
  # and as second item 'approvement of previous minutes'
  # This methods enriches the stored items by those two.
  def item_titles
    legacy? ? items.pluck(:title) : ['Festlegung der Tagesordnung', 'Genehmigung von Protokollen'] + items.pluck(:title)
  end

  validates_presence_of :chairperson_id
  validates_presence_of :keeper_of_the_minutes_id
  validates_presence_of :date

  # All minutes from a meeting before 06.06.2014 are considered legacy.
  # These minutes have no default prefixes and this is schade.
  def legacy?
    date < Date.new(2014, 06, 06)
  end
end
