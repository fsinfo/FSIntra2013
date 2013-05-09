class TabMailer < ActionMailer::Base

	def paid_email(from_user, user, tab)
		@user = user
		@tab = tab
		@from_user = from_user
		to = "#{@user.displayed_name} <#{@user.email}>"
		from = "#{from_user.displayed_name} <#{from_user.email}>"
		mail(
			from: from,
			to: to,
			subject: 'Eine deiner Rechnungen ist als bezahlt markiert'
			)
	end

	def tab_email(from_user, user, tab)
		@user = user
		@from_user = from_user
		@tab = tab
		@beverage_tabs = tab.beverage_tabs
		to = "#{@user.displayed_name} <#{@user.email}>"
		from = "#{@from_user.displayed_name} <#{@from_user.email}>"
		mail(
				from: from,
				to: to,
				subject: 'Es gibt eine neue Getränkeabrechnung')
	end
end
