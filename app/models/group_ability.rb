# frozen_string_literal: true

class GroupAbility
  include CanCan::Ability

  def initialize(user)
    can :create, Group
    can [:destroy, :update], Group, created_by: user
    can [:index, :show, :users, :books], Group, users: { id: user.id }
  end
end
