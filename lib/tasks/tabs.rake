namespace :tabs do
	# Only send mails for tabs that are not marked as paid and if they were
	# set to STATUS_UNPAID more than a week ago (are older than a week)
	desc "Send a mail for every unpaid tab"
	task :send_unpaid_mails => :environment do
		week_ago = 1.week.ago
	    Tab.where(status: Tab::STATUS_UNPAID).where("updated_at < ?", week_ago).each do |tab|
	      TabMailer.tab_email(tab).deliver
	    end
	end
end