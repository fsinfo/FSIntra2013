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
	before_save :create_remember_token 
	before_validation :fill_with_ldap
	validates :email, :format => { :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i }

	has_many :tabs

	has_many :minutes

	def debts
		self.tabs.unpaid.map(&:total_invoice).inject(0,:+)
	end

	def self.authenticate(loginname,password)
		ldap = Net::LDAP.new(:host => 'ford.fachschaft.cs.uni-kl.de')
		ldap.auth("cn=#{loginname},ou=users,dc=fachschaft,dc=informatik,dc=uni-kl,dc=de",password)
		if ldap.bind
			return User.find_or_create_by(:loginname => loginname)
		else 
			return nil
		end
	end

	def has_group?(group)
		# TODO: remove return true
		return true

		ldap = Net::LDAP.new(:host => 'ford.fachschaft.informatik.uni-kl.de')
		if ldap.bind
			filter = Net::LDAP::Filter.eq('memberUid', self.loginname)
			groups = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter, :attributes => ['cn']).flat_map(&:cn)
			return groups.include?(group)
		else
			return false
		end
	end

	# Returns the users that have the LDAP-group 'fsr'
	def self.fsr
		ldap = Net::LDAP.new(:host => 'ford.fachschaft.informatik.uni-kl.de')
		if ldap.bind
			filter = Net::LDAP::Filter.eq('cn', 'fsr')
			loginnames = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter).flat_map(&:memberuid)
			return User.where(:loginname => loginnames)
		else 
			return []
		end
	end

	private 
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end

		def fill_with_ldap
			ldap = Net::LDAP.new(:host => 'ford.fachschaft.informatik.uni-kl.de')
			filter = Net::LDAP::Filter.eq('cn',self.loginname)
			self.firstname= ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter, :attributes => ['cn']).first.cn.last if self.firstname.nil? or self.firstname.empty?
			self.lastname = ldap.search(:base => 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de', :filter => filter, :attributes => ['sn']).first.sn.first if self.lastname.nil? or self.lastname.empty?
			self.email = "#{self.loginname}@cs.uni-kl.de" if self.email.nil?
		end
end
