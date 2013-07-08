class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :manage, User, :id => current_user.id
    can :read, User
    cannot :manage, Beverage
    can :read, Tab, :user_id => current_user.id

    if user.has_group? 'kuehlschrank'
      can :manage, Beverage
      can :manage, Tab
      can :manage, TallySheet
    end
  end
end
