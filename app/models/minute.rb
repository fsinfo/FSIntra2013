class Minute < ActiveRecord::Base
	# Protocols are in one of those statuses
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

end
