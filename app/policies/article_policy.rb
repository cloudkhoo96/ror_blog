class ArticlePolicy < ApplicationPolicy

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end

  def edit?
    user.admin? || record.user == user
  end
end
