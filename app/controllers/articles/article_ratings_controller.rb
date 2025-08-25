class Articles::ArticleRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @article.article_ratings.create(user: current_user)
    render_turbo_stream_update
  end

  def destroy
    @article.article_ratings.find_by(user: current_user).destroy
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def render_turbo_stream_update
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update(
          "like_count_#{@article.id}",
          partial: "articles/like_count",
          locals: { article: @article }
        )
      }
      format.html { redirect_to @article }
    end
  end
end