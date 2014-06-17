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

      ## Minutes

      # Keeper of the minutes abilities
      can [:update, :send_draft, :publish], Minutes::Minute, :keeper_of_the_minutes_id => user.id
      can :manage, Minutes::Item, minute: {:keeper_of_the_minutes_id => user.id }
      can :manage, Minutes::Motion, item: { minute: {:keeper_of_the_minutes_id => user.id} }
      can :manage, Minutes::Approvement, minute: {:keeper_of_the_minutes_id => user.id}
      can :create, Minutes::Item
      can :create, Minutes::Motion
      can :create, Minutes::Approvement

      # Everybody's rules
      can :create, Minutes::Minute
      can :read, Minutes::Minute
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
