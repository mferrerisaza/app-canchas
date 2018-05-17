class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def edit?
    record.users.size.zero?
  end

  def update?
    edit?
  end

  def show?
    # Should be if user belongs to the booking
    true
  end
end
