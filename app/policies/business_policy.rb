class BusinessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true  # Tengamos esto así por ahora para que no moleste cuando queramos crear si no somos business_owners
    # user.business_owner
  end

  def new?
    create?
  end
end
