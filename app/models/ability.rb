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
      cannot :delete, User
      can [:read, :mark_as_paid], Tab, :user_id => user.id

      # Minutes
      can [:update, :send_draft], Minutes::Minute, :keeper_of_the_minutes_id => user.id
      can :create, Minutes::Item
      can :manage, Minutes::Item do |item|
        not item.minute or item.minute.keeper_of_the_minutes == user
      end
      can :manage, Minutes::Motion do |motion|
        not motion.item or motion.item.minute.keeper_of_the_minutes == user
      end

      can :read, Minutes::Minute
      can :create, Minutes::Minute
    end

    # Additional abilities for users with group 'kuehlschrank'
    if user.has_group? 'kuehlschrank' or Rails.env == "development"
      can :manage, Beverage
      can :manage, Tab
      can :manage, :tally_sheet
    end
  end
end
