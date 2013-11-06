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

  validates_presence_of :chairperson_id
  validates_presence_of :keeper_of_the_minutes_id
  validates_presence_of :date
end
