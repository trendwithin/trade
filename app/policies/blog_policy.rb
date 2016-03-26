class BlogPolicy < ApplicationPolicy

  def index?
    user.present? && (user.admin? || user.registered?)
  end

  def new?
    user.present? && user.admin?
  end

  def show?
    index?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    user.present? && user.admin?
  end

  def create?
    user.present? && user.admin?
  end
end
