class BookPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.user == user
  end

  def show?
    record.user == user
  end

  def statistics?
    record.user == user
  end

  def settings?
    record.user == user
  end

  def index?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def download?
    record.user == user
  end

  def modal_chapters?
    record.published?
  end
end
