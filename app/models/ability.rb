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
      can [:read, :mark_as_paid, :detail], Tab, :user_id => user.id
      can [:edit, :update], Tab, {:user_id => user.id, :status => Tab::STATUS_RUNNING}

      # Minutes
      can [:update, :send_draft, :publish], Minutes::Minute, :keeper_of_the_minutes_id => user.id
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
    if user.has_group? 'kuehlschrank'
      can :manage, Beverage
      can :manage, Tab
      cannot :edit, Tab, :status => Tab::STATUS_PAID
      can :manage, :tally_sheet
    end

    # Minutes' CEO's abilities
    can :manage, [Minutes::Minute, Minutes::Motion, Minutes::Item] if user.has_group? 'protokolle'
  end
end
