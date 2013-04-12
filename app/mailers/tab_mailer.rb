class TabMailer < ActionMailer::Base
	default from: "from@example.com"

	def paid_email(user, tab)
		@user = user
		@tab = tab
		to = "#{@user.displayed_name} <#{@user.email}>"
		mail(to: to,
         subject: 'Eine deiner Rechnungen ist als bezahlt markiert')
	end

	def tab_email(user, tab)
		@user = user
		@tab = tab
		@beverage_tabs = tab.beverage_tabs
		to = "#{@user.displayed_name} <#{@user.email}>"
		mail(to: to,
         subject: 'Es gibt eine neue Getränkeabrechnung')
	end
end
