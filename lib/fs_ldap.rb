require 'net/ldap'

class FsLdap
  @@host = 'ford.fachschaft.informatik.uni-kl.de'
  @@base = 'dc=fachschaft,dc=informatik,dc=uni-kl,dc=de'
  @@ldap = Net::LDAP.new(:host => @@host)

  def self.get_lastname(loginname)
    filter = Net::LDAP::Filter.eq('cn',loginname)
    return @@ldap.search(:base => @@base, :filter => filter, :attributes => ['sn']).first.sn.first 
  end

  def self.get_firstname(loginname)
    filter = Net::LDAP::Filter.eq('cn',loginname)
    return @@ldap.search(:base => @@base, :filter => filter, :attributes => ['cn']).first.cn.last
  end

  def self.loginnames_of_group(group)
    filter = Net::LDAP::Filter.eq('cn', group)
    return @@ldap.search(:base => @@base, :filter => filter).flat_map(&:memberuid)
  end

  def self.groups_of_loginname(loginname)
    filter = Net::LDAP::Filter.eq('memberUid', loginname)
    return @@ldap.search(:base => @@base, :filter => filter, :attributes => ['cn']).flat_map(&:cn)
  end

  def self.authenticate(loginname, password)
    lderp = Net::LDAP.new(:host => @@host)
    lderp.auth("cn=#{loginname},ou=users,#{@@base}",password)
    return lderp.bind
  end
end
