class ChapterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(:published => true)
    end
  end

  def show?
    record.user == user || record.published
  end

  def index?
    skip_authorization
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
