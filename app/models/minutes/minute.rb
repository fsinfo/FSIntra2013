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

  # Attendances are defined in the 'base-join-table' attendances,
  # which also has a column 'type'. This is used in order to
  # distinguish between FSR attendees and guests (extendable).
  has_many :fsr_attendances, -> { where type: :fsr }, class_name: 'Minutes::Attendance'
  has_many :fsr_attendants, through: :fsr_attendances, source: :user
  has_many :guest_attendances, -> { where type: :guest }, class_name: 'Minutes::Attendance'
  has_many :guest_attendants, through: :guest_attendances, source: :user

  validates_presence_of :chairperson_id
  validates_presence_of :keeper_of_the_minutes_id
  validates_presence_of :date
end
