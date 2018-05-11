class FieldPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def create?
    # Tengamos esto asi por ahora para que no moleste
    # Cuando queramos crear si no somos business_owners
    true
    # user.business_owner
  end

  def new?
    create?
  end
end
