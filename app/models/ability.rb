class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    cannot :manage, :all

    # Abilities for normal users
    unless user.new_record?
      can :read, Person
      can :manage, Person, :type => nil
      can :manage, User, :id => user.id
      can [:read, :mark_as_paid], Tab, :user_id => user.id
    end

    # Additional abilities for users with group 'kuehlschrank'
    if user.has_group? 'kuehlschrank' or Rails.env == "development"
      can :manage, Beverage
      can :manage, Tab
      can :manage, :tally_sheet
    end
  end
end
