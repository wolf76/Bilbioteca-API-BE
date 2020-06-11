# frozen_string_literal: true

class BookAbility
  include CanCan::Ability

  def initialize(user)
    can [:create], Book
    can [:index, :show], Book, users: { id: user.id }
    can [:index, :show], Book, groups: { users: { id: user.id } }
    can [:destroy, :update, :users], Book, users: { id: user.id }
  end
end
