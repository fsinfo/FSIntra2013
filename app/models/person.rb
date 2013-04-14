# == Schema Information
#
# Table name: people
#
#  id             :integer          not null, primary key
#  firstname      :string(255)
#  lastname       :string(255)
#  street         :string(255)
#  zip            :string(255)
#  city           :string(255)
#  email          :string(255)
#  phone          :string(255)
#  birthday       :date
#  misc           :text
#  loginname      :string(255)
#  remember_token :string(255)
#  type           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'vpim/vcard'

class Person < ActiveRecord::Base
	def displayed_name
		"#{firstname} #{lastname}"
	end

	def to_vcard
		card = Vpim::Vcard::Maker.make2 do |maker|
			maker.add_name do |name|
				name.given = self.firstname
				name.family = self.lastname
			end

			maker.add_addr do |addr|
				addr.street = self.street
				addr.locality = self.city
				addr.postalcode = self.zip
			end 
			
			maker.add_tel(self.phone) if self.phone?
			maker.add_email(self.email) if self.email?
		end
		return card.to_s
	end
end
