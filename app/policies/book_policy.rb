class BookPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
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
    record.user == user
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
end
