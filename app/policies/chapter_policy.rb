class ChapterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.book.user == user
  end

  def update?
    record.book.user == user
  end

  def destroy?
    record.book.user == user
  end
end
