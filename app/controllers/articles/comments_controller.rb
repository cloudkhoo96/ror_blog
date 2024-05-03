class Articles::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:create, :destroy]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :status)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
