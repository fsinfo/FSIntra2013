namespace :tabs do
	desc "Send a mail for every unpaid tab"
	task :send_unpaid_mails => :environment do
    Tab.unpaid.each do |tab|
      TabMailer.tab_email(tab).deliver
    end
	end
end