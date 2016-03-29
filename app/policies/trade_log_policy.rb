class TradeLogPolicy < ApplicationPolicy
  def index?
    user.present? && (user.registered? || user.admin?)
  end

  def new?
    user.present? && user.admin?
  end

  def create?
   new?
  end

  def edit?
    new?
  end

  def show?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
