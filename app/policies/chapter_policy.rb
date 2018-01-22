class ChapterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    record.user == user || record.published
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
