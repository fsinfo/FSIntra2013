require 'net/ldap'

class FsLdap
  HOST = 'ford.fachschaft.informatik.uni-kl.de'
  BASE = 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de'
  PORT = 636
  LDAP = Net::LDAP.new(:host => HOST, :port => PORT, :encryption => :simple_tls)

  def self.get_lastname(loginname)
    filter = Net::LDAP::Filter.eq('cn',loginname)
    return LDAP.search(:base => BASE, :filter => filter, :attributes => ['sn']).first.sn.first
  end

  def self.get_firstname(loginname)
    filter = Net::LDAP::Filter.eq('cn',loginname)
    return LDAP.search(:base => BASE, :filter => filter, :attributes => ['cn']).first.cn.last
  end

  def self.loginnames_of_group(group)
    filter = Net::LDAP::Filter.eq('cn', group)
    return LDAP.search(:base => BASE, :filter => filter).flat_map(&:memberuid)
  end

  def self.groups_of_loginname(loginname)
    filter = Net::LDAP::Filter.eq('memberUid', loginname)
    return loginname ? LDAP.search(:base => BASE, :filter => filter, :attributes => ['cn']).flat_map(&:cn) : []
  end

  def self.authenticate(loginname, password)
    lderp = Net::LDAP.new(:host => HOST, :port => PORT, :encryption => :simple_tls)
    lderp.auth("cn=#{loginname},ou=users,#{BASE}",password)
    return lderp.bind
  end
end
