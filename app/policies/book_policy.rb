class BookPolicy < ApplicationPolicy
<<<<<<< HEAD
  def show?
    true
  end

  def index?
    true
  end

=======
  
>>>>>>> master
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      scope.all
    end
  end
end
