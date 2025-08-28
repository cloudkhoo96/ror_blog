class Articles::ArticleRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @article.article_ratings.create(user: current_user)
  end

  def destroy
    @article.article_ratings.find_by(user: current_user).destroy
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end