class TabMailer < ActionMailer::Base
	KuehlschrankMail = 'kuehlschrank@fachschaft.cs.uni-kl.de'

	# kuehlschrank submitted a tally sheet
	def tab_email(tab)
		@user = tab.user
		@tab = tab
		to = get_email_with_name(@user)
		mail(
			from: KuehlschrankMail,
			to: to,
			subject: 'Es gibt eine neue Getränkeabrechnung'
			)
	end

	def reminder_email(tab)
		@user = tab.user
		@tab = tab
		to = get_email_with_name(@user)
		mail(
			from: KuehlschrankMail,
			to: to,
			subject: 'Es gibt noch eine Rechnung zu begleichen'
		)
	end

	private
	def get_email_with_name(user)
		"#{user.displayed_name} <#{user.email}>"
	end
end
