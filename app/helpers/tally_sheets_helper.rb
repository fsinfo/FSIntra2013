module TallySheetsHelper
	def gravatar_url(user, height)
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{height}&d=retro"
	end

	def wicked_pdf_image_tag_for_public(img, options={})
		if img[0] == "/"
			new_image = img.slice(1..-1)
			image_tag "file://#{Rails.root.join('public', new_image)}", options
		else
			image_tag "file://#{Rails.root.join('public', 'images', img)}", options
		end
	end
end
