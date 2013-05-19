class TabMailer < ActionMailer::Base

	# kuehlschrank accepts a tab as paid
	def paid_email(tab)
		@user = tab.user
		@tab = tab
		to = get_email_with_name(@user)
		mail(
			from: 'kuehlschrank@fachschaft.cs.uni-kl.de',
			to: to,
			subject: 'Eine deiner Rechnungen ist als bezahlt markiert'
			)
	end

	# kuehlschrank submitted a tally sheet
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

	# a user marks a tab as paid
	def marked_as_paid_email(from_user, tab)
		@from_user = from_user
		to = 'kuehlschrank@fachschaft.cs.uni-kl.de'		
		@tab = tab
		mail(
			from: get_email_with_name(from_user),
			to: to,
			subject: "#{@from_user.displayed_name} hat eine Rechnung als bezahlt markiert"
			)
	end

	private
	def get_email_with_name(user)
		"#{user.displayed_name} <#{user.email}>"
	end
end
