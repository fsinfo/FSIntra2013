# == Schema Information
#
# Table name: minutes
#
#  id                       :integer          not null, primary key
#  date                     :datetime
#  status                   :string(255)      default("draft")
#  created_at               :datetime
#  updated_at               :datetime
#  keeper_of_the_minutes_id :integer
#  chairperson_id           :integer
#

class Minute < ActiveRecord::Base
	# Protocols are in one of those statuses
	# Don't forget to update config/locales/minutes.yml if you change these!
	STATUSES = ['draft', 'accepted']
	validates_inclusion_of :status, :in => STATUSES

	validates_presence_of :date

	has_many :items, :class_name => 'Minutes::Item'
	accepts_nested_attributes_for :items
	
	has_and_belongs_to_many :guests, :class_name => 'Minutes::Guest'

	belongs_to :keeper_of_the_minutes, :class_name => 'User'
	
	belongs_to :chairperson, :class_name => 'User'

	has_and_belongs_to_many :absentees,
													-> { where "absent = 0" },
													join_table: 'invitees',
													class_name: 'User'
	accepts_nested_attributes_for :items

													

	# Accept the existing minute.
	# Returns true		if the status was 'draft' before,
	# and			false 	if the status 'accepted' already.
	def accept
		changed = (status == 'draft')
		update_attributes(:status => 'accepted')
		changed
	end

	def translated_status
		I18n.t(status, :scope => 'minutes')
	end

end
