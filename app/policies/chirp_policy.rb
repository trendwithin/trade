class ChirpPolicy < ApplicationPolicy
  def index?
    user.present? && (user.registered? || user.admin?)
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def edit?
    user.present? && user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
