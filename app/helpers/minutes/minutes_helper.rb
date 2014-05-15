module Minutes::MinutesHelper
	def quorum_line m
		if m.instance_of? Minutes::PlenumMinute
			return '–'
		end
		return m.has_quorum ? 'Ja' : 'Nein'
	end
end
