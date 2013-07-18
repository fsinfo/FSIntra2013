# == Schema Information
#
# Table name: people
#
#  id               :integer          not null, primary key
#  firstname        :string(255)
#  lastname         :string(255)
#  street           :string(255)
#  zip              :string(255)
#  city             :string(255)
#  email            :string(255)
#  phone            :string(255)
#  birthday         :date
#  misc             :text
#  loginname        :string(255)
#  remember_token   :string(255)
#  type             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  on_beverage_list :boolean          default(FALSE)
#

require 'vpim/vcard'

class Person < ActiveRecord::Base
	acts_as_taggable

	def to_s
		displayed_name
	end

	def displayed_name
		"#{self.firstname} #{self.lastname}"	
	end

	def short_name
		"#{self.firstname.first}. #{self.lastname}"
	end

	def to_vcard
		begin 
			card = Vpim::Vcard::Maker.make2 do |maker|
				maker.add_name do |name|
					name.given = self.firstname
					name.family = self.lastname
				end unless self.firstname.nil? and self.lastname.nil?

				maker.add_addr do |addr|
					addr.street = self.street
					addr.locality = self.city
					addr.postalcode = self.zip
				end unless self.street.nil? and self.city.nil? and self.zip.nil?
				
				maker.add_tel(self.phone) if self.phone?
				maker.add_email(self.email) if self.email?
			end
			return card.to_s
		rescue Vpim::Unencodeable 
			return ""
		end
	end

	def time_to_next_birthday
		if self.birthday
	    dif = (self.birthday.change(year: Date.today.year) - Date.today)
	    if dif < 0 
	    	next_birthday = self.birthday.change(year: Date.today.next_year.year).to_time
	    else
	    	next_birthday = self.birthday.change(year: Date.today.year).to_time
	    end
	    return next_birthday - Time.now
	  else
	  	return Float::MAX
	  end
	end
end
