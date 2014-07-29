namespace :tabs do
	# Only send mails for tabs that are not marked as paid and if they were
	# set to STATUS_UNPAID more than a week ago (are older than a week)
	desc "Send a mail for every unpaid tab"
	task :send_unpaid_mails => :environment do
		week_ago = 1.week.ago
	    Tab.where(status: Tab::STATUS_UNPAID).where("updated_at < ?", week_ago).each do |tab|
	      TabMailer.reminder_email(tab).deliver
	    end
	end

	# send mails where the tabs' invoice is greater than 0.0
	# remove tabs that have an invoice == 0
	desc "Send accounting mails"
	task :do_accounting => :environment do
		@tabs = Tab.running
		ActiveRecord::Base.transaction do
			@tabs.each do |tab|
				tab.destroy unless tab.total_invoice > 0
			end
		end

		# change status from running to unpaid
		@new_tabs = Tab.running.all
		Tab.running.update_all(:status => Tab::STATUS_UNPAID)

		# send a mail for every unpaid tab
		@new_tabs.each do |tab|
			TabMailer.tab_email(tab).deliver
		end
	end
end
