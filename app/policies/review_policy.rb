class ReviewPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    new?
  end

  def update?
    record.user == user || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
