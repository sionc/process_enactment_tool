# This model represents access level for different roles of users

class Ability
  include CanCan::Ability

  # Initializes the user access levels
  def initialize(user)
    user ||= User.new # guest user
    if user.role? :admin
      can :manage, :all
    elsif user.role? :regular_user
      can :manage, [Project, ProjectPhase, Deliverable, EffortLog]
      cannot :read, User
      can :index, [Lifecycle]
      can :read, [Lifecycle]
      cannot :create, [Lifecycle]
      cannot :update, [Lifecycle]
      cannot :destroy, [Lifecycle]
      cannot :manage, LifecyclePhase
    end
  end
end
