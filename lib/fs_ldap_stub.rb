# A stub for the ldap
# It is mainly for testing the layout/ability to to things
# with certain groups. 
# Authenticate returns true always.
class FsLdap
  @groups = Hash.new {|h,k| h[k]=[]}
  @users = Hash.new {|h,k| h[k]=[]}

  def self.get_lastname(loginname)
    loginname
  end

  def self.get_firstname(loginname)
    loginname
  end

  def self.loginnames_of_group(group)
    @groups[group]
  end

  def self.groups_of_loginname(loginname)
    @users[loginname]
  end

  def self.authenticate(loginname, password)
    true
  end

  def self.add_groups(loginname, *groups)
    return if groups.compact.empty?
    group_list = groups.flatten

    group_list.each do |g|
      @groups[g] << loginname
      @groups[g].uniq!
      @users[loginname] << g
      @users[loginname].uniq!
    end
  end

  # Add the users to the groups here
  self.add_groups('kuehlschrank', 'kuehlschrank')
  self.add_groups('protokolle', 'protokolle')
  self.add_groups('it', 'it')
  self.add_groups('kuehlprot', 'kuehlschrank', 'protokolle')
end
