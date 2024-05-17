class CommentPolicy < ApplicationPolicy
  def update?
    user == record.try(:user)
  end

  def destroy?
    user == record.try(:user)
  end
end
