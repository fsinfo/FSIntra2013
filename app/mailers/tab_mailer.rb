class TabMailer < ActionMailer::Base
	KuehlschrankMail = 'kuehlschrank@fachschaft.cs.uni-kl.de'

	# kuehlschrank accepts a tab as paid
	def paid_email(tab)
		@user = tab.user
		@tab = tab
		to = get_email_with_name(@user)
		mail(
			from: KuehlschrankMail,
			to: to,
			subject: 'Eine deiner Rechnungen ist als bezahlt markiert'
			)
	end

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

	# a user marks a tab as paid
	def marked_as_paid_email(tab)
		@from_user = tab.user
		@tab = tab
		mail(
			from: get_email_with_name(@from_user),
			to: KuehlschrankMail,
			subject: "#{@from_user.displayed_name} hat eine Rechnung als bezahlt markiert"
			)
	end

	private
	def get_email_with_name(user)
		"#{user.displayed_name} <#{user.email}>"
	end
end
