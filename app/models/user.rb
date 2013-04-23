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

	def debts
		self.tabs.unpaid.map(&:total_invoice).inject(0,:+)
	end

	def self.authenticate(loginname,password)
		ldap = Net::LDAP.new(:host => 'ford.fachschaft.cs.uni-kl.de')
		ldap.auth("cn=#{loginname},ou=users,dc=fachschaft,dc=informatik,dc=uni-kl,dc=de",password)
		if ldap.bind
			# create a new user if it doesn't exist yet
			user = User.find_or_create_by(:loginname => loginname)
			return user
		else 
			return nil
		end
	end

	def has_group?(group)
		# TODO: remove return true
		return true

		ldap = Net::LDAP.new(:host => 'ford.fachschaft.informatik.uni-kl.de')
		if ldap.bind
			filter = Net::LDAP::Filter.eq('memberUid', current_user.loginname)
			groups = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter, :attributes => ['cn']).flat_map(&:cn)
			return groups.include?(group)
		else
			return false
		end
	end

	# Returns the loginnames of all members who are in the 'fsr' group in an array
	def self.fsr
		ldap = Net::LDAP.new(:host => 'ford.fachschaft.informatik.uni-kl.de')
		if ldap.bind
			filter = Net::LDAP::Filter.eq('cn', 'fsr')
			loginnames = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter).flat_map(&:memberuid)
			result = []
			users = User.where(:loginname => loginnames).find_each do |u|
				result << u
			end
			return result
		else 
			return []
		end
	end


	private 
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end

end
