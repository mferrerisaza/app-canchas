class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.joins(:users).where(users: { id: user.id })
      end
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def edit?
    user.admin
  end

  def update?
    edit?
  end

  def show?
    # Should be if user belongs to the booking
    true
  end
end
