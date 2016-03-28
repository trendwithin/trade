class CommentPolicy < ApplicationPolicy

  def edit?
    user.present? && user.admin?
  end

  def new?
    user.present? && (user.registered? || user.admin?)
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    user.present? && user.admin?
  end
end
