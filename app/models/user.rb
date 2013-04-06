require 'net/ldap'
class User < ActiveRecord::Base

	def self.authenticate(loginname,password)
		ldap = Net::LDAP.new(:host => 'ford.fachschaft.cs.uni-kl.de')
		ldap.auth("cn=#{loginname},ou=users,dc=fachschaft,dc=informatik,dc=uni-kl,dc=de",password)
		if ldap.bind
			# create a new user if it doesn't exist yet
			user = User.find_or_create_by_loginname(loginname)
			return true
		else 
			return false
		end
	end
end
