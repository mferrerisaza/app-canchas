class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    true
  end

  def show?
    # Should be if user belongs to the booking
    true
  end
end
