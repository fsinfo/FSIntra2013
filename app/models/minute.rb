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
	STATUSES = ['draft', 'published']
	#validates_inclusion_of :status, :in => STATUSES


	validates_presence_of :date
	validates_presence_of :keeper_of_the_minutes_id
	validates_presence_of :chairperson_id

	validates_associated :items

	has_many :items, -> { order '"order" ASC' }, :class_name => 'Minutes::Item'
	accepts_nested_attributes_for :items, :allow_destroy => true

	has_one :minute_approve_item, :class_name => 'Minutes::MinuteApproveItem'
	accepts_nested_attributes_for :minute_approve_item

	has_and_belongs_to_many :guests, :class_name => 'Minutes::Guest'

	belongs_to :keeper_of_the_minutes, :class_name => 'User'
	
	belongs_to :chairperson, :class_name => 'User'

	has_and_belongs_to_many :absentees,
													-> { where "absent = 'With'" },
													join_table: 'invitees',
													class_name: 'User'
	
  has_and_belongs_to_many :unexcused_absentees,
  												-> { where "absent = 'Without'" },
  												join_table: 'invitees',
  												class_name: 'User'

	scope :draft, -> {where :status => 'draft' }
	scope :published, -> {where :status => 'published' }
	scope :accepted, -> { published.where :id => Minutes::MinuteApproveMotion.all.map(&:minute_id).inject([],:<<) }
	scope :acceptable, -> { published.where "id not in (?)", Minutes::MinuteApproveMotion.all.map(&:minute_id).inject([],:<<) }
	
	def attendees
		User.fsr - self.absentees - self.unexcused_absentees
	end


	# Accept the existing minute.
	# Returns true		if the status was 'draft' before,
	# and			false 	if the status 'accepted' already.
	def publish
		changed = !published?
		self.status = 'published'
		changed
	end

	def unpublish
		changed = published?
		self.status = 'draft'
		changed
	end

	def published?
		status == 'published'
	end

	def translated_status
		I18n.t(status, :scope => 'minutes')
	end

end
