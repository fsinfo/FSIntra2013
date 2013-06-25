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

require 'fs_ldap'

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
		user = User.find_or_create_by(:loginname => loginname) if FsLdap::authenticate(loginname,password)
	end

	# LDAP-Gruppen: fsinfo, it, ewoche, ausland, kasse, kai, fete, 
	#								fsk, pr, hh, sprecher, fsl, kuehlschrank, datenschutz, vlu, pa, stupa, protokolle, fbr, 
	#								fit, events, homepage, kommunikation, fsr, ausleihe, oe
	def has_group?(group)
		Rails.env == 'development' ? true : FsLdap::groups_of_loginname(self.loginname).include?(group)
	end

	# Returns the users that have the LDAP-group 'fsr'
	def self.fsr
		loginnames = FsLdap::loginnames_of_group('fsr')
		return User.where(:loginname => loginnames)
	end

	private 
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end

		def fill_with_ldap
			self.firstname= FsLdap::get_firstname(self.loginname) if self.firstname.nil? or self.firstname.empty?
			self.lastname = FsLdap::get_lastname(self.loginname) if self.lastname.nil? or self.lastname.empty?
			self.email = "#{self.loginname}@cs.uni-kl.de" if self.email.nil?
		end
end
