class ArticlePolicy < ApplicationPolicy

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? || record == user
  end
end
