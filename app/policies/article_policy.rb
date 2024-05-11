class ArticlePolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def update?
    article.user == user
  end

  def destroy?
    article.user == user
  end
end
