module TallySheetsHelper
	def gravatar_url(user, height)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{height}&d=retro"
	end
end
