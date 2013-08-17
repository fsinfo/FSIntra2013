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
#  has_quorum               :boolean
#

class Minute < ActiveRecord::Base
	# Protocols are in one of those statuses
	# Don't forget to update config/locales/minutes.yml if you change these!
	STATUSES = ['draft', 'published']
  validates :status, :inclusion => { :in => STATUSES }

	validates_presence_of :date
	validates_presence_of :keeper_of_the_minutes_id
	validates_presence_of :chairperson_id

	validates_associated :items

	has_many :items, -> { order '"order" ASC' }, :class_name => 'Minutes::Item', :dependent => :destroy
	accepts_nested_attributes_for :items, :allow_destroy => true

	has_one :minute_approve_item, :class_name => 'Minutes::MinuteApproveItem', :dependent => :destroy
	accepts_nested_attributes_for :minute_approve_item

	has_and_belongs_to_many :guests, :class_name => 'Minutes::Guest'

	belongs_to :keeper_of_the_minutes, :class_name => 'User'
	belongs_to :chairperson, :class_name => 'User'


  ### Attendance state of fsr members
  # This is a uncool workaround for recognizing the absent-scope
  # as transparent as possible..
	has_many :attendance_attendees, -> { where :absent => '' }, :class_name => 'Minutes::Attendance'
	has_many :attendees, :through => :attendance_attendees, :class_name => 'User' , :source => :user

	has_many :attendance_absentees, -> { where :absent => 'absent' }, :class_name => 'Minutes::Attendance'
	has_many :absentees, :through => :attendance_absentees, :class_name => 'User' , :source => :user
	
	has_many :attendance_unexcused_absentees, -> { where :absent => 'unexcused' }, :class_name => 'Minutes::Attendance'
	has_many :unexcused_absentees, :through => :attendance_unexcused_absentees, :class_name => 'User' , :source => :user
  
	# This method sets the attendance of the FSR members correctly.
  # Since the FSR changes from time to time, we can infer the 
	# absent members by subtracting the attendees from the fsr
	# but we must set this explicitly
	def set_attendance
		fsr = User.fsr.map(&:id)
		self.absentee_ids = fsr - self.attendee_ids
	end

  ### End attendance


	scope :draft, -> {where :status => 'draft' }
	scope :published, -> {where :status => 'published' }
	scope :approved, -> { published.where(:id => Minutes::MinuteApproveMotion.select(:minute_id).where(:approved => true)) }
	scope :approvable, -> { published.where.not :id => Minutes::MinuteApproveMotion.select(:minute_id).where(:approved => true) }
	
  before_save :set_attendance

	def approved?
		Minute.approved.exists?(self) == 1
	end

	# Returns the minute (if existent) where this minute was approved
	def approving_minute
		motion = Minutes::MinuteApproveMotion.where(:minute_id => self.id).where(:approved => true)
		motion.first.minute_approve_item.minute
	end

	# Approve the existing minute.
	# Returns true		if the status was 'draft' before,
	# and			false 	if the status 'approved' already.
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


	# Input: A string of comma seperated names of guests, e.g.
	#   "Hans Wagner, Torben von Klein, Otto Mops"
	# This method creates the Minutes::Guest if necessary and 
	# sets up the relationship between self and the guests.
	def update_guests g
		guest_strings = g.split ','
		guest_strings.map do |x|
			guest = Minutes::Guest.find_or_create_by :name => x.strip # no whitespaces
			self.guests = self.guests | [guest]
		end
	end

end
