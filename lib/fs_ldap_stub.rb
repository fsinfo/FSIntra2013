class FsLdap
  @groups = Hash.new {|h,k| h[k]=[]}
  @users = Hash.new {|h,k| h[k]=[]}

  def self.get_lastname(loginname)
    User.find_by(loginname: loginname).lastname
  end

  def self.get_firstname(loginname)
    User.find_by(loginname: loginname).firstname
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
end
