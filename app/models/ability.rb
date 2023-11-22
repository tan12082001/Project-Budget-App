# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    return unless current_user.present?

    can :manage, [Category, Expenditure], user: current_user
  end
end
