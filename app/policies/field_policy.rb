class FieldPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    true # Tengamos esto asi por ahora para que
    # no moleste cuando queramos crear si no somos business owners
  end

  def new?
    create?
  end
end
