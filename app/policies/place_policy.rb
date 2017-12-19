class PlacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.book.user == user
  end

  def destroy?
    record.book.user == user
  end
end
