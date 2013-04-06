class Minute < ActiveRecord::Base
	# Protocols are in one of those statuses
	# Don't forget to update config/locales/minutes.yml if you change these!
	STATUSES = ['draft', 'accepted']
	validates_inclusion_of :status, :in => STATUSES

	validates_presence_of :date

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
