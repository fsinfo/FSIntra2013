class TabMailer < ActionMailer::Base

	def paid_email(from_user, to_user, tab)
		@user = to_user
		@tab = tab
		@from_user = from_user
		to = get_email_with_name(@user)
		from = get_email_with_name(@from_user)
		mail(
			from: from,
			to: to,
			subject: 'Eine deiner Rechnungen ist als bezahlt markiert'
			)
	end

	def tab_email(from_user, to_user, tab)
		@user = to_user
		@from_user = from_user
		@tab = tab
		@beverage_tabs = tab.beverage_tabs
		to = get_email_with_name(@user)
		from = get_email_with_name(@from_user)
		mail(
			from: from,
			to: to,
			subject: 'Es gibt eine neue Getränkeabrechnung'
			)
	end

	def marked_as_paid_email(from_user, to, tab)
		@user = user
		@from_user = from_user
		@tab = tab
		mail(
			from: from,
			to: to,
			subject: "#{@user.displayed_name} hat eine Rechnung als bezahlt markiert"
			)
	end

	private
	def get_email_with_name(user)
		"#{user.displayed_name} <#{user.email}>"
	end
end
