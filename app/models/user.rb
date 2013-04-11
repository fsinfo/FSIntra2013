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

require 'net/ldap'
class User < Person
	has_many :tabs
	before_save :create_remember_token

	has_many :minutes


	scope :fsr

	def debts
		self.tabs.unpaid.map(&:total_invoice).inject(0,:+)
	end

	def self.authenticate(loginname,password)
		ldap = Net::LDAP.new(:host => 'ford.fachschaft.cs.uni-kl.de')
		ldap.auth("cn=#{loginname},ou=users,dc=fachschaft,dc=informatik,dc=uni-kl,dc=de",password)
		if ldap.bind
			filter = Net::LDAP::Filter.eq('memberUid', loginname)
			groups = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter, :attributes => ['cn']).flat_map(&:cn)

			# create a new user if it doesn't exist yet
			user = User.find_or_create_by(:loginname => loginname)
			return user, groups
		else 
			return nil
		end
	end

	def displayed_name
		"#{firstname} #{lastname}"
	end

	private 
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end

end
